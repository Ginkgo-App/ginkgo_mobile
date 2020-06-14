part of 'tour_list_bloc.dart';

@immutable
abstract class TourListState {
  @override
  String toString() => runtimeType.toString();
}

class TourListInitial extends TourListState {}

class TourListStateLoading extends TourListState {}

class TourListStateSuccess extends TourListState {
  final Pagination<SimpleTour> tourList;

  TourListStateSuccess(this.tourList);

  @override
  String toString() =>
      '$runtimeType ${tourList.data.length} / ${tourList.pagination.totalPage}';
}

class TourListStateFailure extends TourListState {
  final dynamic error;

  TourListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
