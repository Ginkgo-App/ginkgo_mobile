part of 'place_list_bloc.dart';

@immutable
abstract class PlaceListEvent {
  @override
  String toString() => runtimeType.toString();
}

class PlaceListEventFetch extends PlaceListEvent {
  final String keyword;
  final PlaceSearchType type;
  final int page;
  final int pageSize;

  PlaceListEventFetch(this.keyword, this.type, this.page, this.pageSize);

  @override
  String toString() =>
      '$runtimeType Keyword: $keyword Type: $type Page: $page PageSize: $pageSize';
}
