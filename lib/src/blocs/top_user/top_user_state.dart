part of 'top_user_bloc.dart';

@immutable
abstract class TopUserState {
  @override
  String toString() => runtimeType.toString();
}

class TopUserInitial extends TopUserState {}

class TopUserStateLoading extends TopUserState {}

class TopUserStateSuccess extends TopUserState {
  final Pagination<SimpleUser> topUserList;

  TopUserStateSuccess(this.topUserList);

  @override
  String toString() => '$runtimeType ${topUserList.data.length}';
}

class TopUserStateFailure extends TopUserState {
  final dynamic error;

  TopUserStateFailure(this.error);

  @override
  String toString() => '$runtimeType ${error.stackTrace}';
}
