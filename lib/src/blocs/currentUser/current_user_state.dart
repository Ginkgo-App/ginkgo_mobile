part of 'current_user_bloc.dart';

@immutable
abstract class CurrentUserState {
  @override
  String toString() => runtimeType.toString();
}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserStateLoading extends CurrentUserState {}

class CurrentUserStateSuccess extends CurrentUserState {
  final User currentUser;

  CurrentUserStateSuccess(this.currentUser);

  @override
  String toString() => '$runtimeType ${currentUser.toJsonString()}';
}

class CurrentUserStateFailure extends CurrentUserState {
  final String error;

  CurrentUserStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

class CurrentUserStateHaveChanges extends CurrentUserState {}
