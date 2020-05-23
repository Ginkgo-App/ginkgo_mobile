part of 'current_user_bloc.dart';

@immutable
abstract class CurrentUserEvent {
  @override
  String toString() => runtimeType.toString();
}

class CurrentUserEventFetch extends CurrentUserEvent {}

class CurrentUserEventOnHaveChanges extends CurrentUserEvent {
  final User newInfo;

  CurrentUserEventOnHaveChanges(this.newInfo);

  @override
  String toString() => '$runtimeType ${newInfo.toJson()}';
}
