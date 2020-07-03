part of 'tour_detail_bloc.dart';

@immutable
abstract class TourDetailState {
  @override
  String toString() => runtimeType.toString();
}

class TourDetailInitial extends TourDetailState {}

class TourDetailStateLoading extends TourDetailState {}

class TourDetailStateLoadingMore extends TourDetailState {}

class TourDetailStateSuccess extends TourDetailState {}

class TourDetailStateLoadMoreSuccess extends TourDetailState {}

class TourDetailStateFailure extends TourDetailState {
  final dynamic error;

  TourDetailStateFailure(this.error);

  @override
  String toString() => '$runtimeType ${error.stackTrace}';
}

class TourDetailStateLoadMoreFailure extends TourDetailState {
  final dynamic error;

  TourDetailStateLoadMoreFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
