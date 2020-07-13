part of 'tour_members_bloc.dart';

@immutable
abstract class TourMembersEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourMembersEventFetch extends TourMembersEvent {
  final String keyword;

  TourMembersEventFetch([this.keyword = '']);
}

class TourMembersEventLoadMore extends TourMembersEvent {
  final bool force;

  TourMembersEventLoadMore(this.force);
}

class TourMembersEventOnChange extends TourMembersEvent {}
