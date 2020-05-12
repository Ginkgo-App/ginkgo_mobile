part of 'user_friend_bloc.dart';

@immutable
abstract class UserFriendEvent {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendEventFetch extends UserFriendEvent {
  final int userId;

  UserFriendEventFetch(this.userId);

  @override
  String toString() => '$runtimeType $userId';
}
