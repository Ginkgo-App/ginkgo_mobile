part of 'user_bloc.dart';

@immutable
abstract class UserState {
  @override
  String toString() => runtimeType.toString();
}

class UserInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateSuccess extends UserState {
  final User user;

  UserStateSuccess(this.user);

  @override
  String toString() => '$runtimeType ${user.toJsonString()}';
}

class UserStateFailure extends UserState {
  final String error;

  UserStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
