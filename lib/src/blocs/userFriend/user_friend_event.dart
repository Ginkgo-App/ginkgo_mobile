part of 'user_friend_bloc.dart';

@immutable
abstract class UserFriendEvent {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendEventFetch extends UserFriendEvent {
  final int userId;
  final int page;
  final int pageSize;
  final FriendType type;

  UserFriendEventFetch(this.userId,
      {this.page = 1, this.pageSize = 6, this.type = FriendType.none});

  @override
  String toString() => '$runtimeType $userId Page: $page PageSize: $pageSize';
}
