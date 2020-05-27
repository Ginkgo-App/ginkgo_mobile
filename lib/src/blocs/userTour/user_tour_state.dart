part of 'user_tour_bloc.dart';

@immutable
abstract class UserTourState {
  @override
  String toString() => runtimeType.toString();
}

class UserTourInitial extends UserTourState {}

class UserTourLoading extends UserTourState {}

class UserTourSuccess extends UserTourState {
  final Pagination<SimpleTour> tours;

  UserTourSuccess(this.tours);

  @override
  String toString() => '$runtimeType ${tours.pagination.toJsonString()}';
}

class UserTourFailure extends UserTourState {
  final String error;

  UserTourFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
