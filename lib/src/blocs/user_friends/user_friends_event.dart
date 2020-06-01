part of 'user_friends_bloc.dart';

@immutable
abstract class UserFriendsEvent {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendsEventFirstFetch extends UserFriendsEvent {}

class UserFriendsEventLoadMore extends UserFriendsEvent {}

class UserFriendsEventRemoveFromList extends UserFriendsEvent {
  final int userId;

  UserFriendsEventRemoveFromList(this.userId);

  @override
  String toString() => '$runtimeType $userId';
}

class UserFriendsEventAddToList extends UserFriendsEvent {
  final SimpleUser user;

  UserFriendsEventAddToList(this.user);

  @override
  String toString() => '$runtimeType ${user.id}';
}
