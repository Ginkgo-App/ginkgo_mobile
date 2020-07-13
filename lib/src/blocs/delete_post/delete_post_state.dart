part of 'delete_post_bloc.dart';

@immutable
abstract class DeletePostState {
  @override
  String toString() => runtimeType.toString();
}

class DeletePostInitial extends DeletePostState {}

class DeletePostStateLoading extends DeletePostState {
  final int postId;

  DeletePostStateLoading(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}

class DeletePostStateFailure extends DeletePostState {
  final dynamic error;
  final int postId;

  DeletePostStateFailure(this.error, this.postId);

  @override
  String toString() => '$runtimeType $postId $error';
}

class DeletePostStateSuccess extends DeletePostState {
  final int postId;

  DeletePostStateSuccess(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
