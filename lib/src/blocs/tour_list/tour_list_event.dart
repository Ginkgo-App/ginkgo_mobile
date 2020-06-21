part of 'tour_list_bloc.dart';

@immutable
abstract class TourListEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourListEventFetch extends TourListEvent {
  final String keyword;

  TourListEventFetch({this.keyword});

  @override
  String toString() => '$runtimeType Keyword: $keyword';
}
