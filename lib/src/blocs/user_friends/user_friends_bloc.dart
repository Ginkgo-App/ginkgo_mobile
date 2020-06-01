import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:ginkgo_mobile/src/utils/constrains.dart';
import 'package:meta/meta.dart';

part 'user_friends_event.dart';
part 'user_friends_state.dart';

class UserFriendsBloc extends Bloc<UserFriendsEvent, UserFriendsState> {
  final Repository _repository = Repository();
  final FriendType friendType;
  final SimpleUser user;
  final bool isCurrentUser;

  List<SimpleUser> _friendList;

  UserFriendsBloc._({this.isCurrentUser, this.user, this.friendType});

  factory UserFriendsBloc.forCurrentUser(FriendType friendType) =>
      UserFriendsBloc._(
        friendType: friendType,
        isCurrentUser: true,
      );

  factory UserFriendsBloc.forOtherUser(SimpleUser user) => UserFriendsBloc._(
        friendType: FriendType.accepted,
        user: user,
        isCurrentUser: false,
      );

  List<SimpleUser> get friendList => _friendList;
  Pagination<SimpleUser> _pagination;
  Pagination<SimpleUser> get pagination => _pagination;

  @override
  UserFriendsState get initialState => UserFriendsInitial();

  @override
  Stream<UserFriendsState> mapEventToState(
    UserFriendsEvent event,
  ) async* {
    if (event is UserFriendsEventFirstFetch) {
      try {
        yield UserFriendsStateLoading();

        if (isCurrentUser) {
          _pagination = await _repository.user.getMeFriends(friendType,
              page: 1, pageSize: Constains.DEFAULT_PAGE_SIZE);
        } else {
          _pagination = await _repository.user.getUserFriends(user.id,
              page: 1, pageSize: Constains.DEFAULT_PAGE_SIZE);
        }
        _friendList = _pagination.data;

        yield FriendsStateSuccess(_pagination);
      } catch (e) {
        yield UserFriendsStateFailure(e.toString());
      }
    } else if (event is UserFriendsEventLoadMore &&
        _pagination.pagination.currentPage < _pagination.pagination.totalPage &&
        _friendList.length > 0) {
      try {
        yield UserFriendsStateLoadingMore();

        if (isCurrentUser) {
          _pagination = await _repository.user.getMeFriends(friendType,
              page: _pagination.pagination.currentPage + 1,
              pageSize: Constains.DEFAULT_PAGE_SIZE);
        } else {
          _pagination = await _repository.user.getUserFriends(user.id,
              page: _pagination.pagination.currentPage + 1,
              pageSize: Constains.DEFAULT_PAGE_SIZE);
        }
        _friendList.addAll(_pagination.data);
        yield FriendsStateSuccess(_pagination);
      } catch (e) {
        yield UserFriendsStateLoadMoreFailure(e.toString());
      }
    } else if (isCurrentUser && event is UserFriendsEventRemoveFromList) {
      friendList.removeWhere((e) => e.id == event.userId);
      yield FriendsStateSuccess(_pagination);
    } else if (isCurrentUser && event is UserFriendsEventAddToList) {
      friendList.insert(0, event.user);
      yield FriendsStateSuccess(_pagination);
    }
  }
}
