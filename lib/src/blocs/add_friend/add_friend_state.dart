part of 'add_friend_bloc.dart';

@immutable
abstract class AddFriendState {
  @override
  String toString() => runtimeType.toString();
}

class AddFriendInitial extends AddFriendState {}

class AddFriendStateLoading extends AddFriendState {}

class AddFriendStateSuccess extends AddFriendState {
  final SimpleUser user;

  AddFriendStateSuccess(this.user);
}

class AddFriendStateFailure extends AddFriendState {
  final dynamic error;

  AddFriendStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
