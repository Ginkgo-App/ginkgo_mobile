part of repo;

class _TourRepository {
  final TourProvider _tourProvider = TourProvider();

  Future<Tour> getDetail(int tourId) => _tourProvider.getDetail(tourId);

  Future<Pagination<SimpleTour>> getList(
          {int page, int pageSize, String keyword}) =>
      _tourProvider.getList(keyword: keyword, page: page, pageSize: pageSize);

  Future create(TourToPost tourToPost) => _tourProvider.create(tourToPost);
}
