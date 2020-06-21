part of 'place_list_bloc.dart';

@immutable
abstract class PlaceListEvent {
  @override
  String toString() => runtimeType.toString();
}

class PlaceListEventFetch extends PlaceListEvent {
  final String keyword;
  final PlaceSearchType type;

  PlaceListEventFetch(this.keyword, this.type);

  @override
  String toString() => '$runtimeType Keyword: $keyword Type: $type';
}

class PlaceListEventFetchBestList extends PlaceListEvent {}
