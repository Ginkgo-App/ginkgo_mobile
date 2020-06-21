part of 'place_detail_bloc.dart';

@immutable
abstract class PlaceDetailState {
  @override
  String toString() => runtimeType.toString();
}

class PlaceDetailInitial extends PlaceDetailState {}

class PlaceDetailStateLoading extends PlaceDetailState {}

class PlaceDetailStateSuccess extends PlaceDetailState {}

class PlaceDetailStateFailure extends PlaceDetailState {
  final dynamic error;

  PlaceDetailStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
