part of 'user_friend_bloc.dart';

@immutable
abstract class UserFriendState {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendInitial extends UserFriendState {}

class UserFriendLoading extends UserFriendState {}

class UserFriendSuccess extends UserFriendState {
  final Pagination<SimpleUser> users;

  UserFriendSuccess(this.users);

  @override
  String toString() => '$runtimeType ${users.pagination.toJsonString()}';
}

class UserFriendFailure extends UserFriendState {
  final String error;

  UserFriendFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
