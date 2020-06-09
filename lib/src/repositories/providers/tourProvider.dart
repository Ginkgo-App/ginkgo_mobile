part of providers;

class TourProvider {
  final _client = ApiClient();

  Future<Pagination<Tour>> getList(
      {int page, int pageSize, String keyword, PlaceSearchType type}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.places, query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
      if (type != null) 'type': enumToString(type),
      if (keyword != null) 'keyword': keyword,
    });

    return Pagination<Tour>(response.data['Pagination'], response.data['Data']);
  }
}
