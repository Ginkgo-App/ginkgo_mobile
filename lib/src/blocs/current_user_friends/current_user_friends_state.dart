part of 'current_user_friends_bloc.dart';

@immutable
abstract class CurrentUserFriendsState {
  @override
  String toString() => runtimeType.toString();
}

class CurrentUserFriendsInitial extends CurrentUserFriendsState {}

class CurrentUserFriendsStateLoading extends CurrentUserFriendsState {
}

class CurrentUserFriendsStateLoadingMore
    extends CurrentUserFriendsState {}

class CurrentUserFriendsStateSuccess extends CurrentUserFriendsState {
  final Pagination<SimpleUser> friends;

  CurrentUserFriendsStateSuccess(this.friends);

  @override
  String toString() =>
      '$runtimeType ${friends.data.map((e) => e.id).toString()}';
}

class CurrentUserFriendsStateFailure extends CurrentUserFriendsState {
  final dynamic error;

  CurrentUserFriendsStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

class CurrentUserFriendsStateLoadMoreFailure extends CurrentUserFriendsState {
  final dynamic error;

  CurrentUserFriendsStateLoadMoreFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
