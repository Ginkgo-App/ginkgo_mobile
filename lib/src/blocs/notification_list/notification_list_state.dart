part of 'notification_list_bloc.dart';

@immutable
abstract class NotificationListState {
  @override
  String toString() => runtimeType.toString();
}

class NotificationListInitial extends NotificationListState {}

class NotificationListStateLoading extends NotificationListState {
  final bool isLoadMore;

  NotificationListStateLoading({this.isLoadMore = false});

  @override
  String toString() => '$runtimeType $isLoadMore';
}

class NotificationListStateSuccess extends NotificationListState {
  final Pagination<NotificationInfo> notificationList;

  NotificationListStateSuccess(this.notificationList);

  @override
  String toString() => '$runtimeType ${notificationList.data.length}';
}

class NotificationListStateFailure extends NotificationListState {
  final dynamic error;

  NotificationListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
