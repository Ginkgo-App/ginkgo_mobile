part of 'user_friend_bloc.dart';

@immutable
abstract class UserFriendState {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendStateInitial extends UserFriendState {}

class UserFriendStateLoading extends UserFriendState {}

class UserFriendStateSuccess extends UserFriendState {
  final Pagination<SimpleUser> users;

  UserFriendStateSuccess(this.users);

  @override
  String toString() => '$runtimeType ${users.pagination.toJsonString()}';
}

class UserFriendStateFailure extends UserFriendState {
  final String error;

  UserFriendStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
