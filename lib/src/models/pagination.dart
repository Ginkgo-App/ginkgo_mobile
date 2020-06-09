part of 'models.dart';

class Pagination<T> {
  _PaginationDetail pagination = _PaginationDetail();
  List<T> data = [];

  bool get canLoadmore => pagination.currentPage < pagination.totalPage;

  Pagination([Map<String, dynamic> paginationJson, List dataJson])
      : pagination = paginationJson == null
            ? _PaginationDetail()
            : Mapper.fromJson(paginationJson).toObject<_PaginationDetail>(),
        data = dataJson == null
            ? []
            : dataJson.map((e) => Mapper.fromJson(e).toObject<T>()).toList();

  Pagination.dev({
    @required this.data,
    @required int totalPage,
    @required int totalElement,
    @required int currentPage,
    @required int pageSize,
  }) {
    pagination = _PaginationDetail();
    pagination.totalElement = totalElement;
    pagination.totalPage = totalPage;
    pagination.currentPage = currentPage;
    pagination.pageSize = pageSize;
  }
}

class _PaginationDetail with Mappable {
  int totalPage = 0;
  int totalElement = 0;
  int currentPage = 0;
  int pageSize = 0;

  @override
  void mapping(Mapper map) {
    map('TotalPage', totalPage, (v) => totalPage = v);
    map('TotalElement', totalElement, (v) => totalElement = v);
    map('CurrentPage', currentPage, (v) => currentPage = v);
    map('PageSize', pageSize, (v) => pageSize = v);
  }
}
