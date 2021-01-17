import 'dart:async';

import 'package:base/base.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/controllers/index.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc _authBloc = AuthBloc._();

  factory AuthBloc() => _authBloc;
  AuthBloc._();

  final Repository _repository = Repository();

  @override
  AuthState get initialState => AuthStateInitial();

  @override
  Future<void> close() {
    if (_authBloc != null) {
      _authBloc.close();
      _authBloc = null;
    }
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is AuthEventStartApp) {
        await for (final state in _startApp(event)) yield state;
      } else if (event is AuthEventAuth) {
        await for (final state in _onLogin(event)) yield state;
      } else if (event is AuthEventLogout) {
        await for (final state in _onLogout(event)) yield state;
      }
    } catch (error) {
      yield AuthStateFailure(error);
      yield AuthStateUnauthenticated();
      _goToLogin();
    }
  }

  Stream<AuthState> _startApp(AuthEventStartApp event) async* {
    if (await _repository.auth.isAuth) {
      yield AuthStateLoading();
      CurrentUserBloc().add(CurrentUserEventFetch());
      try {
        await CurrentUserBloc().waitOne([CurrentUserStateSuccess],
            throwStates: [CurrentUserStateFailure]);
        _goToHome();
        yield AuthStateAuthenticated();
      } catch (_) {}
    } else {
      yield AuthStateUnauthenticated();
      _goToLogin();
    }
  }

  Stream<AuthState> _onLogin(AuthEventAuth event) async* {
    try {
      CurrentUserBloc().add(CurrentUserEventFetch());
      await CurrentUserBloc().waitOne([CurrentUserStateSuccess],
          throwStates: [CurrentUserStateFailure]);
      _goToHome();
      yield AuthStateAuthenticated();
    } catch (_) {}
  }

  Stream<AuthState> _onLogout(AuthEventLogout event) async* {
    yield AuthStateLoading();
    await _repository.auth.logout();
    _goToLogin();
    Get.reset();
    initControllers();
    yield AuthStateUnauthenticated();
  }

  _goToHome() {
    AppConfig.navigatorKey.currentState
        .pushNamedAndRemoveUntil(Routes.home, (_) => false);
  }

  _goToLogin() => AppConfig.navigatorKey.currentState
      .pushNamedAndRemoveUntil(Routes.login, (_) => false);
}
