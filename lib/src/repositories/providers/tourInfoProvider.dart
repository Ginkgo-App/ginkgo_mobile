part of providers;

class TourInfoProvider {
  final _client = ApiClient();

  Future<Pagination<TourInfo>> getList(
      {int page, int pageSize, String keyword}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.tourInfos(null), query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
      if (keyword != null) 'keyword': keyword,
    });

    return Pagination<TourInfo>(
        response.data['Pagination'], response.data['Data']);
  }

  Future<TourInfo> getDetail(int tourInfoId) async {
    final result = await _client.connect<TourInfo>(
        ApiMethod.GET, Api.tourInfos(tourInfoId));
    return result;
  }

  Future<Pagination<SimpleTour>> getTourList(int tourInfoId,
      {int page, int pageSize}) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, Api.tourInfosTourList(tourInfoId),
        query: {
          'page': (page ?? 1).toString(),
          'pageSize': pageSize?.toString() ?? 0,
        });

    return Pagination<SimpleTour>(
        response.data['Pagination'], response.data['Data']);
  }

  Future<TourInfo> create(TourInfoToPost tourInfoToPost) async {
    final List<String> images = [];

    if (tourInfoToPost.images.length > 0) {
      final system = SystemProvider();
      images.addAll(
        await Future.wait(
          tourInfoToPost.images.map((i) => system.uploadImage(i)).toList(),
        ),
      );
    }

    final tourInfo = await _client.connect<TourInfo>(
      ApiMethod.POST,
      Api.tourInfos(null),
      body: {
        'DestinatePlaceId': tourInfoToPost.destinatePlace.id,
        'StartPlaceId': tourInfoToPost.startPlace.id,
        'Name': tourInfoToPost.name,
        'Images': images,
      },
    );

    return tourInfo;
  }
}
