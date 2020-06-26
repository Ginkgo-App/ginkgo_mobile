part of 'post_comment_bloc.dart';

@immutable
abstract class PostCommentEvent {
  @override
  String toString() => runtimeType.toString();
}

class PostCommentEventCreatePost extends PostCommentEvent {
  final PostToPost postToPost;

  PostCommentEventCreatePost(this.postToPost);

  @override
  String toString() =>
      '$runtimeType {Content: ${postToPost.content}, Images: ${postToPost.images?.length}, TourId: ${postToPost.tourId}, Rating: ${postToPost.rating}}';
}

class PostCommentEventCreateComment extends PostCommentEvent {
  final CommentToPost commentToPost;

  PostCommentEventCreateComment(this.commentToPost);
}
