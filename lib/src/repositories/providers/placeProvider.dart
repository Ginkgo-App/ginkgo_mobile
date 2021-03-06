part of providers;

class PlaceProvider {
  final _client = ApiClient();

  Future<Place> getDetail(int placeId) async {
    final result =
        await _client.connect<Place>(ApiMethod.GET, Api.places(placeId));

    return result;
  }

  Future<Pagination<Place>> getList(
      {int page, int pageSize, String keyword, PlaceSearchType type}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.places(null), query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
      if (type != null) 'type': enumToString(type),
      if (keyword.isExistAndNotEmpty) 'keyword': keyword,
    });

    return Pagination<Place>(
        response.data['Pagination'], response.data['Data']);
  }
}
