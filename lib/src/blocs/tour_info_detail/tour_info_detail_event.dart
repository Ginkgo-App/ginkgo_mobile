part of 'tour_info_detail_bloc.dart';

@immutable
abstract class TourInfoDetailEvent {
  @override
  String toString() => runtimeType.toString();
}

class TourInfoDetailEventFetch extends TourInfoDetailEvent {
  final int tourInfoId;

  TourInfoDetailEventFetch(this.tourInfoId);

  @override
  String toString() =>
      '$runtimeType tourInfoId: $tourInfoId';
}

class TourInfoDetailEventLoadMore extends TourInfoDetailEvent {}
