part of 'current_user_friends_bloc.dart';

@immutable
abstract class CurrentUserFriendsEvent {
  @override
  String toString() => runtimeType.toString();
}

class CurrentUserFriendsEventFirstFetch extends CurrentUserFriendsEvent {}

class CurrentUserFriendsEventLoadMore extends CurrentUserFriendsEvent {}

class CurrentUserFriendsEventRemoveFromList extends CurrentUserFriendsEvent {
  final int userId;

  CurrentUserFriendsEventRemoveFromList(this.userId);

  @override
  String toString() => '$runtimeType $userId';
}

class CurrentUserFriendsEventAddToList extends CurrentUserFriendsEvent {
  final SimpleUser user;

  CurrentUserFriendsEventAddToList(this.user);

  @override
  String toString() => '$runtimeType ${user.id}';
}
