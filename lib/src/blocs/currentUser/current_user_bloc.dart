import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  static CurrentUserBloc _instance = CurrentUserBloc._();
  CurrentUserBloc._();
  factory CurrentUserBloc() => _instance;

  final Repository _repository = Repository();

  User _currentUser;
  List<User> _friends;

  User get currentUser => _currentUser;
  List<User> get friends => _friends;

  @override
  Future<void> close() {
    _instance.close();
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
        yield CurrentUserLoading();
        _currentUser = await _repository.user.getMe();
        yield CurrentUserSuccess(_currentUser);
      } else if (event is CurrentUserEventOnHaveChanges) {
        _currentUser = event.newInfo;
        yield CurrentUserStateHaveChanges();
      }
    } catch (e) {
      yield CurrentUserFailure(e.toString());
    }
  }
}
