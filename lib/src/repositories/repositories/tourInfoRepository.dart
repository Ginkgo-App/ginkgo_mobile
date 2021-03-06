part of repo;

class _TourInfoRepository {
  final TourInfoProvider _provider = TourInfoProvider();

  /// userId == 0 => me
  Future<Pagination<TourInfo>> getListOfUser(int userId,
          {int page, int pageSize, String keyword}) =>
      _provider.getListOfUser(userId,
          keyword: keyword, page: page, pageSize: pageSize);

  Future<Pagination<TourInfo>> getList(
          {int page, int pageSize, String keyword}) =>
      _provider.getList(keyword: keyword, page: page, pageSize: pageSize);

  Future<TourInfo> create(TourInfoToPost toPost) => _provider.create(toPost);

  Future<TourInfo> getDetail(int tourInfoId) => _provider.getDetail(tourInfoId);

  Future<Pagination<SimpleTour>> getTourList(int tourInfoId,
          {@required int page, @required int pageSize}) =>
      _provider.getTourList(tourInfoId, page: page, pageSize: pageSize);
}
