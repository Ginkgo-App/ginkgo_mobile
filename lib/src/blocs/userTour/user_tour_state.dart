part of 'user_tour_bloc.dart';

@immutable
abstract class UserTourState {
  @override
  String toString() => runtimeType.toString();
}

class UserTourInitial extends UserTourState {}

class UserTourLoading extends UserTourState {}

class UserTourSuccess extends UserTourState {
  final List<SimpleTour> tours;

  UserTourSuccess(this.tours);

  @override
  String toString() => '$runtimeType ${tours.length}';
}

class UserTourFailure extends UserTourState {
  final String error;

  UserTourFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
