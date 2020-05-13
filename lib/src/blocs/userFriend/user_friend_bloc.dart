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
  UserFriendState get initialState => UserFriendInitial();

  @override
  Stream<UserFriendState> mapEventToState(
    UserFriendEvent event,
  ) async* {
    try {
      if (event is UserFriendEventFetch) {
        yield UserFriendLoading();
        final _friends = await _repository.user.getUserFriends(event.userId);
        yield UserFriendSuccess(_friends);
      }
    } catch (e) {
      yield UserFriendFailure(e.toString());
    }
  }
}
