import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'user_friend_event.dart';
part 'user_friend_state.dart';

class UserFriendBloc extends Bloc<UserFriendEvent, UserFriendState> {
  final Repository _repository = Repository();

  List<User> _friends;

  List<User> get friends => _friends;

  @override
  UserFriendState get initialState => UserFriendInitial();

  @override
  Stream<UserFriendState> mapEventToState(
    UserFriendEvent event,
  ) async* {
    try {
      if (event is UserFriendEventFetch) {
        yield CurrentUserMoreLoading();
        final data =
            await Future.wait([_repository.user.getUserFriends(event.userId)]);
        _friends = data[0];
        yield CurrentUserMoreSuccess();
      }
    } catch (e) {
      yield CurrentUserMoreFailure(e.toString());
    }
  }
}
