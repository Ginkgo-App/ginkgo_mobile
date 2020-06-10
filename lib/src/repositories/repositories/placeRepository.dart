part of repo;

class _PlaceRepository {
  final PlaceProvider _placeProvider = PlaceProvider();

  Future<Pagination<Place>> getList(
          {int page, int pageSize, String keyword, PlaceSearchType type}) =>
      _placeProvider.getList(
        keyword: keyword,
        page: page,
        pageSize: pageSize,
        type: type,
      );
}
