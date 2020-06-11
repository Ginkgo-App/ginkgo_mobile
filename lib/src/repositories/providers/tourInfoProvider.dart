part of providers;

class TourInfoProvider {
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

  Future create(TourInfoToPost tourInfoToPost) async {
    final List<String> images = [];

    if (tourInfoToPost.images.length > 0) {
      final system = SystemProvider();
      images.addAll(
        await Future.wait(
          tourInfoToPost.images.map((i) => system.uploadImage(i)).toList(),
        ),
      );
    }

    final response = await _client.normalConnect(
      ApiMethod.POST,
      Api.tourInfos,
      body: {
        'DestinatePlaceId': tourInfoToPost.destinatePlace.id,
        'StartPlaceId': tourInfoToPost.startPlace.id,
        'Name': tourInfoToPost.name,
        'Images': images,
      },
    );

    debugPrint(response.data);

    return;
  }
}
