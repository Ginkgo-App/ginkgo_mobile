import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:ginkgo_mobile/src/utils/constrains.dart';
import 'package:meta/meta.dart';

part 'current_user_friends_event.dart';
part 'current_user_friends_state.dart';

class CurrentUserFriendsBloc
    extends Bloc<CurrentUserFriendsEvent, CurrentUserFriendsState> {
  final FriendType friendType;
  final Repository _repository = Repository();

  List<SimpleUser> _friendList;

  CurrentUserFriendsBloc(this.friendType);

  List<SimpleUser> get friendList => _friendList;
  Pagination<SimpleUser> _pagination;
  Pagination<SimpleUser> get pagination => _pagination;

  @override
  CurrentUserFriendsState get initialState => CurrentUserFriendsInitial();

  @override
  Stream<CurrentUserFriendsState> mapEventToState(
    CurrentUserFriendsEvent event,
  ) async* {
    if (event is CurrentUserFriendsEventFirstFetch) {
      try {
        yield CurrentUserFriendsStateLoading();

        _pagination = await _repository.user.getMeFriends(friendType,
            page: 1, pageSize: Constains.DEFAULT_PAGE_SIZE);

        _friendList = _pagination.data;
        yield CurrentUserFriendsStateSuccess(_pagination);
      } catch (e) {
        yield CurrentUserFriendsStateFailure(e.toString());
      }
    } else if (event is CurrentUserFriendsEventLoadMore) {
      try {
        yield CurrentUserFriendsStateLoading();

        _pagination = await _repository.user.getMeFriends(friendType,
            page: _pagination.pagination.currentPage + 1,
            pageSize: Constains.DEFAULT_PAGE_SIZE);
        _friendList.addAll(_pagination.data);
        yield CurrentUserFriendsStateSuccess(_pagination);
      } catch (e) {
        yield CurrentUserFriendsStateLoadMoreFailure(e.toString());
      }
    } else if (event is CurrentUserFriendsEventRemoveFromList) {
      friendList.removeWhere((e) => e.id == event.userId);
      yield CurrentUserFriendsStateSuccess(_pagination);
    } else if (event is CurrentUserFriendsEventAddToList) {
      friendList.insert(0, event.user);
      yield CurrentUserFriendsStateSuccess(_pagination);
    }
  }
}
