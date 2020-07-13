part of 'comment_list_bloc.dart';

@immutable
abstract class CommentListState {
  @override
  String toString() => runtimeType.toString();
}

class CommentListInitial extends CommentListState {}

class CommentListStateLoading extends CommentListState {
  final bool isLoadMore;

  CommentListStateLoading({this.isLoadMore = false});

  @override
  String toString() => '$runtimeType $isLoadMore';
}

class CommentListStateSuccess extends CommentListState {
  final Pagination<Comment> commentList;

  CommentListStateSuccess(this.commentList);

  @override
  String toString() => '$runtimeType ${commentList.data.length}';
}

class CommentListStateFailure extends CommentListState {
  final dynamic error;

  CommentListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
