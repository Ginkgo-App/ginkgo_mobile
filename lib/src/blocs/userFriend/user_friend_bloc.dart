import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'user_friend_event.dart';
part 'user_friend_state.dart';

class UserFriendBloc extends Bloc<UserFriendEvent, UserFriendState> {
  final Repository _repository = Repository();

  @override
  UserFriendState get initialState => UserFriendStateInitial();

  Pagination<SimpleUser> friendList = Pagination();

  @override
  Stream<UserFriendState> mapEventToState(
    UserFriendEvent event,
  ) async* {
    try {
      if (event is UserFriendEventFetch) {
        yield UserFriendStateLoading();
        if (event.userId == 0) {
          friendList = await _repository.user.getMeFriends(event.type,
              page: event.page, pageSize: event.pageSize);
        } else {
          friendList = await _repository.user.getUserFriends(event.userId,
              page: event.page, pageSize: event.pageSize);
        }
        yield UserFriendStateSuccess(friendList);
      }
    } catch (e) {
      yield UserFriendStateFailure(e.toString());
    }
  }
}
