import 'dart:async';

import 'package:base/base.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:ginkgo_mobile/src/screens/screens.dart';
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
        await for (final state in _onFacebookLogin(event)) yield state;
      } else if (event is AuthScreenEventFacebookLoginWithEmail) {
        await for (final state in _onFacebookLoginWithEmail(event)) yield state;
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

  Stream<AuthScreenState> _onFacebookLogin(
      AuthScreenEventFacebookLogin event) async* {
    yield AuthScreenStateLoading();
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          await _repository.auth.loginFacebook(result.accessToken.token);
        } on ServerError catch (e) {
          if (e.errorCode == 9) {
            AppConfig.navigatorKey.currentState.pushReplacementNamed(
                Routes.email,
                arguments: EmailScreenArgs(result.accessToken.token));
            return;
          } else
            throw e;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        yield AuthScreenStateSuccess();
        return;
      case FacebookLoginStatus.error:
        throw result.errorMessage;
    }

    AuthBloc().add(AuthEventAuth());
    yield AuthScreenStateSuccess();
  }

  Stream<AuthScreenState> _onFacebookLoginWithEmail(
      AuthScreenEventFacebookLoginWithEmail event) async* {
    yield AuthScreenStateLoading();
    await _repository.auth.loginFacebook(event.accessToken, event.email);

    AuthBloc().add(AuthEventAuth());
    yield AuthScreenStateSuccess();
  }
}
