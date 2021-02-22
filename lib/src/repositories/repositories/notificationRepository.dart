part of repo;

class _NotificationRepository {
  final NotificationProvider _notificationProvider = NotificationProvider();

  Future<Pagination<NotificationInfo>> getList({int page, int pageSize}) =>
      _notificationProvider.getList(
        page: page,
        pageSize: pageSize,
      );
}
