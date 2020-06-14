part of 'tour_list_bloc.dart';

@immutable
abstract class TourListEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourListEventFetch extends TourListEvent {
  final TourListType type;
  final String keyword;

  TourListEventFetch({this.keyword, @required this.type});

  @override
  String toString() => '$runtimeType Type: $type Keyword: $keyword';
}

class TourListEventFetchOfUser extends TourListEvent {
  final String keyword;
  final int userId;

  TourListEventFetchOfUser({this.keyword, @required this.userId});

  @override
  String toString() => '$runtimeType UserId: $userId Keyword: $keyword';
}

class TourListEventFetchOfMe extends TourListEvent {
  final String keyword;
  final MeTourType type;

  TourListEventFetchOfMe({this.keyword, @required this.type});

  @override
  String toString() => '$runtimeType Type: $type Keyword: $keyword';
}
