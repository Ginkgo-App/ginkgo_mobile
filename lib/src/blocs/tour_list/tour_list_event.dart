part of 'tour_list_bloc.dart';

@immutable
abstract class TourListEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourListEventFetch extends TourListEvent {
  final bool refresh;
  final String keyword;

  TourListEventFetch({this.keyword, this.refresh = false});

  @override
  String toString() => '$runtimeType Keyword: $keyword Refresh:$refresh';
}
