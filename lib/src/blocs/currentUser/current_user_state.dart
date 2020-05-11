part of 'current_user_bloc.dart';

@immutable
abstract class CurrentUserState {
  @override
  String toString() => runtimeType.toString();
}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserLoading extends CurrentUserState {}

class CurrentUserSuccess extends CurrentUserState {
  final User currentUser;

  CurrentUserSuccess(this.currentUser);

  @override
  String toString() => '$runtimeType ${currentUser.toJsonString()}';
}

class CurrentUserFailure extends CurrentUserState {
  final String error;

  CurrentUserFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
