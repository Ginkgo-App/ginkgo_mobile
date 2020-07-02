part of 'comment_list_bloc.dart';

@immutable
abstract class CommentListEvent {
  @override
  String toString() => runtimeType.toString();
}

class CommentListEventFetch extends CommentListEvent {}

class CommentListEventLoadMore extends CommentListEvent {
  final bool force;

  CommentListEventLoadMore([this.force = false]);
}
