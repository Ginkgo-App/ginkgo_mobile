part of 'user_friends_bloc.dart';

@immutable
abstract class UserFriendsState {
  @override
  String toString() => runtimeType.toString();
}

class UserFriendsInitial extends UserFriendsState {}

class UserFriendsStateLoading extends UserFriendsState {
}

class UserFriendsStateLoadingMore
    extends UserFriendsState {}

class FriendsStateSuccess extends UserFriendsState {
  final Pagination<SimpleUser> friends;

  FriendsStateSuccess(this.friends);

  @override
  String toString() =>
      '$runtimeType ${friends.data.map((e) => e.id).toString()}';
}

class UserFriendsStateFailure extends UserFriendsState {
  final dynamic error;

  UserFriendsStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

class UserFriendsStateLoadMoreFailure extends UserFriendsState {
  final dynamic error;

  UserFriendsStateLoadMoreFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
