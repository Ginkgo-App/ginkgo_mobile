part of 'like_post_bloc.dart';

@immutable
abstract class LikePostState {
  @override
  String toString() => runtimeType.toString();
}

class LikePostInitial extends LikePostState {}

class LikePostStateLoading extends LikePostState {
  final int postId;

  LikePostStateLoading(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}

class LikePostStateFailure extends LikePostState {
  final dynamic error;
  final int postId;

  LikePostStateFailure(this.error, this.postId);

  @override
  String toString() => '$runtimeType $postId $error';
}

class LikePostStateSuccess extends LikePostState {
  final int postId;

  LikePostStateSuccess(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
