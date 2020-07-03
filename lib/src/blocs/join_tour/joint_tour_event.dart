part of 'join_tour_bloc.dart';

abstract class JointTourEvent {}

class JointTourEventJoint extends JointTourEvent {
  final int postId;

  JointTourEventJoint(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}

class JointTourEventLeave extends JointTourEvent {
  final int postId;

  JointTourEventLeave(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
