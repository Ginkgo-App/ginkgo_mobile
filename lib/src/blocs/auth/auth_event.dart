part of 'auth_bloc.dart';

abstract class AuthEvent {
  @override
  String toString() => runtimeType.toString();
}

class AuthEventStartApp extends AuthEvent {}

class AuthEventAuth extends AuthEvent {}

class AuthEventLogout extends AuthEvent {}
