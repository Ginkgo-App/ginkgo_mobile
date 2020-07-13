part of 'join_tour_bloc.dart';

@immutable
abstract class JoinTourState {
  @override
  String toString() => runtimeType.toString();
}

class JoinTourInitial extends JoinTourState {}

class JoinTourStateLoading extends JoinTourState {
  final int tourId;

  JoinTourStateLoading(this.tourId);

  @override
  String toString() => '$runtimeType $tourId';
}

class JoinTourStateFailure extends JoinTourState {
  final dynamic error;
  final int tourId;

  JoinTourStateFailure(this.error, this.tourId);

  @override
  String toString() => '$runtimeType $tourId $error';
}

class JoinTourStateSuccess extends JoinTourState {
  final int tourId;
  final bool isLeave;

  JoinTourStateSuccess(this.tourId, this.isLeave);

  @override
  String toString() => '$runtimeType $tourId';
}
