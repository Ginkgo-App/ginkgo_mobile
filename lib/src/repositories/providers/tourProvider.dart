part of providers;

class TourProvider {
  final _client = ApiClient();

  Future<Tour> getDetail(int tourId) async {
    final result = await _client.connect(ApiMethod.GET, Api.tour(tourId));

    return result;
  }

  Future<Pagination<TourMember>> getMembers(int tourId,
      {int page, int pageSize, String keyword, TourMembersType type}) async {
    final response = await _client
        .normalConnect(ApiMethod.GET, Api.tour(tourId) + '/members', query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
      if (type != null) 'type': enumToString(type),
      if (keyword != null) 'keyword': keyword,
    });

    return Pagination<TourMember>(
        response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<Post>> getReviews(int tourId,
      {int page, int pageSize}) async {
    final response = await _client
        .normalConnect(ApiMethod.GET, Api.tour(tourId) + '/feedbacks', query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
    });

    return Pagination<Post>(response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<SimpleTour>> getList(
      {int page, int pageSize, String keyword, TourListType type}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.tour(null), query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
      if (type != null) 'type': enumToString(type),
      if (keyword != null) 'keyword': keyword,
    });

    return Pagination<SimpleTour>(
        response.data['Pagination'], response.data['Data']);
  }

  Future<int> create(TourToPost tourToPost) async {
    final response = await _client.normalConnect(
      ApiMethod.POST,
      Api.tourInTourInfo(tourToPost.tourInfoId),
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
                        if (detail.place != null) 'PlaceId': detail.place.id,
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

    return response.data['Data'][0]['Id'];
  }
}
