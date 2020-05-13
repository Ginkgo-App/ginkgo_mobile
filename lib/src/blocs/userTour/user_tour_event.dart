part of 'user_tour_bloc.dart';

@immutable
abstract class UserTourEvent {
  @override
  String toString() => runtimeType.toString();
}

class UserTourEventFetch extends UserTourEvent {
  final int userId;

  UserTourEventFetch(this.userId);

  @override
  String toString() => '$runtimeType $userId';
}
