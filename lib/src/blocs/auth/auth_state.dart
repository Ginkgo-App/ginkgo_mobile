part of 'auth_bloc.dart';

abstract class AuthState {
  @override
  String toString() => runtimeType.toString();
}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateAuthenticated extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateFailure extends AuthState {
  final dynamic error;

  AuthStateFailure(this.error);

  @override
  String toString() => '$runtimeType ${error.toString()}';
}
