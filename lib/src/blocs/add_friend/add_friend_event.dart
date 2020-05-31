part of 'add_friend_bloc.dart';

@immutable
abstract class AddFriendEvent {
  @override
  String toString() => runtimeType.toString();
}

class AddFriendEventAddFriend extends AddFriendEvent {
  final SimpleUser user;

  AddFriendEventAddFriend(this.user);

  @override
  String toString() => '$runtimeType ${user.id}';
}

class AddFriendEventRemoveFriend extends AddFriendEvent {
  final int userId;

  AddFriendEventRemoveFriend(this.userId);

  @override
  String toString() => '$runtimeType $userId';
}

class AddFriendEventAcceptFriend extends AddFriendEvent {
  final SimpleUser user;

  AddFriendEventAcceptFriend(this.user);

  @override
  String toString() => '$runtimeType ${user.id}';
}
