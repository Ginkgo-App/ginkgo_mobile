part of 'like_post_bloc.dart';

@immutable
abstract class LikePostState {
  @override
  String toString() => runtimeType.toString();
}

class LikePostInitial extends LikePostState {}

class LikePostStateLoading extends LikePostState {
  final int postId;
  final bool isLiked;

  LikePostStateLoading(this.postId, this.isLiked);

  @override
  String toString() => '$runtimeType $postId $isLiked';
}

class LikePostStateFailure extends LikePostState {
  final dynamic error;
  final int postId;
  final bool isLiked;

  LikePostStateFailure(this.error, this.postId, this.isLiked);

  @override
  String toString() => '$runtimeType $postId $isLiked $error';
}

class LikePostStateSuccess extends LikePostState {
  final int postId;

  LikePostStateSuccess(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
