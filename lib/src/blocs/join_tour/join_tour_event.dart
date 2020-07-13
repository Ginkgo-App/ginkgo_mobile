part of 'join_tour_bloc.dart';

@immutable
abstract class JoinTourEvent {}

class JoinTourEventJoin extends JoinTourEvent {
  final int tourId;

  JoinTourEventJoin(this.tourId);

  @override
  String toString() => '$runtimeType $tourId';
}

class JoinTourEventLeave extends JoinTourEvent {
  final int postId;

  JoinTourEventLeave(this.postId);

  @override
  String toString() => '$runtimeType $postId';
}
