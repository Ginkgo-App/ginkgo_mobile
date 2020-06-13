part of 'tour_info_detail_bloc.dart';

@immutable
abstract class TourInfoDetailState {
  @override
  String toString() => runtimeType.toString();
}

class TourInfoDetailInitial extends TourInfoDetailState {}

class TourInfoDetailStateLoading extends TourInfoDetailState {}

class TourInfoDetailStateLoadingMore extends TourInfoDetailState {}

class TourInfoDetailStateSuccess extends TourInfoDetailState {}

class TourInfoDetailStateLoadMoreSuccess extends TourInfoDetailState {}

class TourInfoDetailStateFailure extends TourInfoDetailState {
  final dynamic error;

  TourInfoDetailStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}

class TourInfoDetailStateLoadMoreFailure extends TourInfoDetailState {
  final dynamic error;

  TourInfoDetailStateLoadMoreFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
