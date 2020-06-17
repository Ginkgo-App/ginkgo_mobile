part of 'tour_reviews_bloc.dart';

@immutable
abstract class TourReviewsEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourReviewsEventFetch extends TourReviewsEvent {
  final int tourId;

  TourReviewsEventFetch({@required this.tourId});

  @override
  String toString() => '$runtimeType TourId: $tourId';
}
