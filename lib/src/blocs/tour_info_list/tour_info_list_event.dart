part of 'tour_info_list_bloc.dart';

@immutable
abstract class TourInfoListEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourInfoListEventFetch extends TourInfoListEvent {
  final String keyword;
  final int page;
  final int pageSize;

  TourInfoListEventFetch(this.keyword, this.page, this.pageSize);

  @override
  String toString() =>
      '$runtimeType Keyword: $keyword Page: $page PageSize: $pageSize';
}
