part of 'join_tour_bloc.dart';

abstract class JointTourState {
  @override
  String toString() => runtimeType.toString();
}

class JointTourInitial extends JointTourState {}

class JointTourStateLoading extends JointTourState {
  final int postId;
  final bool isLiked;

  JointTourStateLoading(this.postId, this.isLiked);

  @override
  String toString() => '$runtimeType $postId $isLiked';
}

class JointTourStateFailure extends JointTourState {
  final dynamic error;
  final int postId;
  final bool isLiked;

  JointTourStateFailure(this.error, this.postId, this.isLiked);

  @override
  String toString() => '$runtimeType $postId $isLiked $error';
}

class JointTourStateSuccess extends JointTourState {
  final int postId;

  JointTourStateSuccess(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
