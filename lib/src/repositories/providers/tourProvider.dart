part of providers;

class TourProvider {
  final _client = ApiClient();

  Future<Pagination<SimpleTour>> getList(
      {int page, int pageSize, String keyword, PlaceSearchType type}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.places, query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
      if (type != null) 'type': enumToString(type),
      if (keyword != null) 'keyword': keyword,
    });

    return Pagination<SimpleTour>(
        response.data['Pagination'], response.data['Data']);
  }

  Future create(TourToPost tourToPost) async {
    await _client.normalConnect(
      ApiMethod.POST,
      Api.tour(tourToPost.tourInfoId),
      body: {
        'Name': tourToPost.name,
        'StartDay': tourToPost.startDay.toIso8601String(),
        'EndDay': tourToPost.endDay.toIso8601String(),
        'TotalDay': tourToPost.totalDay,
        'TotalNight': tourToPost.totalNight,
        'MaxMember': tourToPost.maxMember,
        'Services': tourToPost.services,
        'TourInfoId': tourToPost.tourInfoId,
        'Price': tourToPost.price,
        'Timelines': tourToPost.timelines
            .map(
              (timeline) => {
                'Day': timeline.day.toIso8601String(),
                'Description': timeline.descrirption,
                'TimelineDetails': timeline.timelineDetails
                    .map(
                      (detail) => {
                        'PlaceId': detail.place.id,
                        'Time': detail.time,
                        'Detail': detail.detail,
                      },
                    )
                    .toList()
              },
            )
            .toList(),
      },
    );

    return;
  }
}
