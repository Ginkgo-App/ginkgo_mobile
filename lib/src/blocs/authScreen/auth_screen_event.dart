part of 'auth_screen_bloc.dart';

@immutable
abstract class AuthScreenEvent {
  @override
  String toString() => '$runtimeType';
}

class AuthScreenEventLogin extends AuthScreenEvent {
  final String email;
  final String password;

  AuthScreenEventLogin({@required this.email, @required this.password})
      : assert(email != null && password != null);

  @override
  String toString() => '$runtimeType $email, $password';
}

class AuthScreenEventFacebookLogin extends AuthScreenEvent {
  final String accessToken;

  AuthScreenEventFacebookLogin(this.accessToken);

  @override
  String toString() => '$runtimeType $accessToken';
}

class AuthScreenEventFacebookLoginWithEmail extends AuthScreenEvent {
  final String accessToken;
  final String email;

  AuthScreenEventFacebookLoginWithEmail(
      {@required this.accessToken, @required this.email});

  @override
  String toString() => '$runtimeType $email $accessToken';
}

class AuthScreenEventRegister extends AuthScreenEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  AuthScreenEventRegister(
      {this.name, this.email, this.phoneNumber, this.password});

  @override
  String toString() => '$runtimeType $name, $phoneNumber, $email, $password';
}
