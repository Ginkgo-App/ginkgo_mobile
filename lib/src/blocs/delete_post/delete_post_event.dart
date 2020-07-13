part of 'delete_post_bloc.dart';

@immutable
abstract class DeletePostEvent {}

class DeletePostEventDelete extends DeletePostEvent {
  final int postId;

  DeletePostEventDelete(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}

class DeletePostEventUnlike extends DeletePostEvent {
  final int postId;

  DeletePostEventUnlike(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
