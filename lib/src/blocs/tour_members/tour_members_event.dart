part of 'tour_members_bloc.dart';

@immutable
abstract class TourMembersEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourMembersEventFetch extends TourMembersEvent {
  final int tourId;
  final TourMemberType type;
  final String keyword;

  TourMembersEventFetch({@required this.tourId, this.keyword, this.type});

  @override
  String toString() =>
      '$runtimeType TourId: $tourId Type: $type Keyword: $keyword';
}
