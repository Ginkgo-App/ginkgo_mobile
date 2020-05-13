part of 'user_friend_bloc.dart';

@immutable
abstract class UserFriendState {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendInitial extends UserFriendState {}

class UserFriendLoading extends UserFriendState {}

class UserFriendSuccess extends UserFriendState {
  final List<SimpleUser> users;

  UserFriendSuccess(this.users);

  @override
  String toString() => '$runtimeType ${users.length}';
}

class UserFriendFailure extends UserFriendState {
  final String error;

  UserFriendFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
