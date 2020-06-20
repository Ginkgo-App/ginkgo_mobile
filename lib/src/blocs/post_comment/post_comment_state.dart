part of 'post_comment_bloc.dart';

@immutable
abstract class PostCommentState {
  @override
  String toString() => runtimeType.toString();
}

class PostCommentInitial extends PostCommentState {}

class PostCommentStateLoading extends PostCommentState {}

class PostCommentStatePostSuccess extends PostCommentState {
  final int newPostId;

  PostCommentStatePostSuccess(this.newPostId);

  @override
  String toString() => '$runtimeType $newPostId';
}

class PostCommentStateCommentSuccess extends PostCommentState {
  final Comment newComment;

  PostCommentStateCommentSuccess(this.newComment);

  @override
  String toString() => '$runtimeType ${newComment.toJsonString()}';
}

class PostCommentStateFailure extends PostCommentState {
  final dynamic error;

  PostCommentStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
