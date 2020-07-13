part of 'top_user_bloc.dart';

@immutable
abstract class TopUserEvent {
  @override
  String toString() => runtimeType.toString();
}

class TopUserEventFetch extends TopUserEvent {}

class TopUserEventLoadMore extends TopUserEvent {
  final bool force;

  TopUserEventLoadMore([this.force = false]);
}
