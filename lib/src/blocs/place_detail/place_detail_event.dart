part of 'place_detail_bloc.dart';

@immutable
abstract class PlaceDetailEvent {
  @override
  String toString() => runtimeType.toString();
}

class PlaceDetailEventFetch extends PlaceDetailEvent {
  final int placeId;

  PlaceDetailEventFetch(this.placeId);

  @override
  String toString() =>
      '$runtimeType placeId: $placeId';
}
