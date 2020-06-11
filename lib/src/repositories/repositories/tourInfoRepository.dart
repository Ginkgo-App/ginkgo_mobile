part of repo;

class _TourInfoRepository {
  final TourInfoProvider _provider = TourInfoProvider();

  Future<Pagination<Tour>> getList({int page, int pageSize, String keyword}) =>
      _provider.getList(keyword: keyword, page: page, pageSize: pageSize);

  Future create(TourInfoToPost toPost) => _provider.create(toPost);
}
