part of repo;

class _TourInfoRepository {
  final TourInfoProvider _provider = TourInfoProvider();

  Future<Pagination<TourInfo>> getList(
          {int page, int pageSize, String keyword}) =>
      _provider.getList(keyword: keyword, page: page, pageSize: pageSize);

  Future<int> create(TourInfoToPost toPost) => _provider.create(toPost);

  Future<TourInfo> getDetail(int tourInfoId) => _provider.getDetail(tourInfoId);

  Future<Pagination<SimpleTour>> getTourList(int tourInfoId,
          {@required int page, @required int pageSize}) =>
      _provider.getTourList(tourInfoId, page: page, pageSize: pageSize);
}
