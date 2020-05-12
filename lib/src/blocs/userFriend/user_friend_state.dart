part of 'user_friend_bloc.dart';

@immutable
abstract class UserFriendState {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendInitial extends UserFriendState {}

class CurrentUserMoreLoading extends UserFriendState {}

class CurrentUserMoreSuccess extends UserFriendState {}

class CurrentUserMoreFailure extends UserFriendState {
  final String error;

  CurrentUserMoreFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
