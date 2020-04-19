import 'dart:async';

import 'package:base/base.dart';
import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'auth_screen_event.dart';
part 'auth_screen_state.dart';

class AuthScreenBloc extends Bloc<AuthScreenEvent, AuthScreenState> {
  final Repository _repository = Repository();

  @override
  AuthScreenState get initialState => AuthScreenStateInitial();

  @override
  Stream<AuthScreenState> mapEventToState(
    AuthScreenEvent event,
  ) async* {
    try {
      if (event is AuthScreenEventLogin) {
        await for (final state in _onLogin(event)) yield state;
      } else if (event is AuthScreenEventRegister) {
        await for (final state in _onRegister(event)) yield state;
      } else if (event is AuthScreenEventFacebookLogin) {
        await for (final state in _onSocialLogin(event)) yield state;
      }
    } catch (error) {
      yield AuthScreenStateFailure(error);
    }
  }

  Stream<AuthScreenState> _onLogin(AuthScreenEventLogin event) async* {
    yield AuthScreenStateLoading();
    await _repository.auth.login(event.email, event.password);
    AuthBloc().add(AuthEventAuth());
    yield AuthScreenStateSuccess();
  }

  Stream<AuthScreenState> _onRegister(AuthScreenEventRegister event) async* {
    yield AuthScreenStateLoading();
    await _repository.auth.register(
      name: event.name,
      email: event.email,
      phoneNumber: event.phoneNumber,
      password: event.password,
    );
    AuthBloc().add(AuthEventAuth());
    yield AuthScreenStateSuccess();
  }

  Stream<AuthScreenState> _onSocialLogin(
      AuthScreenEventFacebookLogin event) async* {
    yield AuthScreenStateLoading();
    await _repository.auth.loginFacebook(event.accessToken);
    AuthBloc().add(AuthEventAuth());
    yield AuthScreenStateSuccess();
  }
}
