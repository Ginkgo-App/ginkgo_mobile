import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/blocs/user_friends/user_friends_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  static CurrentUserBloc _instance = CurrentUserBloc._();
  CurrentUserBloc._();

  factory CurrentUserBloc() {
    if (_instance == null) {
      _instance = CurrentUserBloc._();
    }

    return _instance;
  }

  final Repository _repository = Repository();
  final UserFriendsBloc acceptedFriendsBloc =
      UserFriendsBloc.forCurrentUser(FriendType.accepted);
  final UserFriendsBloc requestedFriendsBloc =
      UserFriendsBloc.forCurrentUser(FriendType.requested);
  final UserFriendsBloc waitingFriendsBloc =
      UserFriendsBloc.forCurrentUser(FriendType.waiting);

  User _currentUser;
  List<User> _friends;

  User get currentUser => _currentUser;
  List<User> get friends => _friends;

  bool isCurrentUser({SimpleUser simpleUser, User user}) =>
      simpleUser?.id == _currentUser?.id || user?.id == _currentUser?.id;

  @override
  Future<void> close() {
    _instance.close();
    acceptedFriendsBloc.close();
    requestedFriendsBloc.close();
    waitingFriendsBloc.close();
    return super.close();
  }

  @override
  CurrentUserState get initialState => CurrentUserInitial();

  @override
  Stream<CurrentUserState> mapEventToState(
    CurrentUserEvent event,
  ) async* {
    try {
      if (event is CurrentUserEventFetch) {
        yield CurrentUserStateLoading();
        _currentUser = await _repository.user.getMe();
        yield CurrentUserStageSuccess(_currentUser);
      } else if (event is CurrentUserEventOnHaveChanges) {
        _currentUser = event.newInfo;
        yield CurrentUserStateHaveChanges();
      }
    } catch (e) {
      yield CurrentUserStateFailure(e.toString());
    }
  }
}
