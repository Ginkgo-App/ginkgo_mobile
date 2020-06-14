part of repo;

class _TourRepository {
  final TourProvider _tourProvider = TourProvider();

  Future<Pagination<SimpleTour>> getList({int page, int pageSize, String keyword}) =>
      _tourProvider.getList(keyword: keyword, page: page, pageSize: pageSize);

  Future create(TourToPost tourToPost) => _tourProvider.create(tourToPost);
}
