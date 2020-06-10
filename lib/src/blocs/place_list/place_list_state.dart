part of 'place_list_bloc.dart';

@immutable
abstract class PlaceListState {
  @override
  String toString() => runtimeType.toString();
}

class PlaceListInitial extends PlaceListState {}

class PlaceListStateLoading extends PlaceListState {}

class PlaceListStateSuccess extends PlaceListState {
  final Pagination<Place> placeList;

  PlaceListStateSuccess(this.placeList);

  @override
  String toString() => '$runtimeType ${placeList.data.length}';
}

class PlaceListStateFailure extends PlaceListState {
  final dynamic error;

  PlaceListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
