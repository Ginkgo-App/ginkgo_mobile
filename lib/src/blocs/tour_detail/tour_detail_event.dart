part of 'tour_detail_bloc.dart';

@immutable
abstract class TourDetailEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourDetailEventFetch extends TourDetailEvent {
  final int tourId;

  TourDetailEventFetch(this.tourId);

  @override
  String toString() =>
      '$runtimeType tourId: $tourId';
}
