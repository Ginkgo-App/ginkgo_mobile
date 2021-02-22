part of 'notification_list_bloc.dart';

@immutable
abstract class NotificationListEvent {
  @override
  String toString() => runtimeType.toString();
}

class NotificationListEventFetch extends NotificationListEvent {}

class NotificationListEventLoadMore extends NotificationListEvent {
  final bool force;

  NotificationListEventLoadMore([this.force = false]);
}

class CallEventChangeState extends NotificationListEvent {
  CallEventChangeState(this.state);

  final NotificationListState state;
}
