part of providers;

class NotificationProvider {
  final _client = ApiClient();

  Future<Pagination<NotificationInfo>> getList({int page, int pageSize}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.notifications(), query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
    });

    return Pagination<NotificationInfo>(
        response.data['Pagination'], response.data['Data']);
  }
}
