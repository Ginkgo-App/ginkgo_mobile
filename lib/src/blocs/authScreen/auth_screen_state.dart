part of 'auth_screen_bloc.dart';

@immutable
abstract class AuthScreenState {
  @override
  String toString() => runtimeType.toString();
}

class AuthScreenStateInitial extends AuthScreenState {}

class AuthScreenStateLoading extends AuthScreenState {}

class AuthScreenStateSuccess extends AuthScreenState {}

class AuthScreenStateFailure extends ErrorState implements AuthScreenState {
  AuthScreenStateFailure(error) : super(error);
}
