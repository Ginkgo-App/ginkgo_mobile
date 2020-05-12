part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  @override
  String toString() => runtimeType.toString();
}

class UserEventFetch extends UserEvent {
  final int userId;

  UserEventFetch(this.userId);

  @override
  String toString() => '$runtimeType $userId';
}
