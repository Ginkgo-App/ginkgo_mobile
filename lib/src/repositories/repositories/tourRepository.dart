part of repo;

class _TourRepository {
  final TourProvider _tourProvider = TourProvider();

  Future<Tour> getDetail(int tourId) => _tourProvider.getDetail(tourId);

  Future<Pagination<TourMember>> getMembers(int tourId,
          {int page, int pageSize, String keyword, TourMemberType type}) =>
      _tourProvider.getMembers(tourId,
          keyword: keyword, page: page, pageSize: pageSize, type: type);

  Future<Pagination<Post>> getReviews(int tourId, {int page, int pageSize}) =>
      _tourProvider.getReviews(tourId, page: page, pageSize: pageSize);

  Future<Pagination<SimpleTour>> getList(
          {int page, int pageSize, String keyword}) =>
      _tourProvider.getList(keyword: keyword, page: page, pageSize: pageSize);

  Future<int> create(TourToPost tourToPost) =>
      _tourProvider.create(tourToPost);
}
