part of 'like_post_bloc.dart';

@immutable
abstract class LikePostEvent {}

class LikePostEventLike extends LikePostEvent {
  final int postId;

  LikePostEventLike(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
