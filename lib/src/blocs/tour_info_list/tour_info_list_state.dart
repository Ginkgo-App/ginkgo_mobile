part of 'tour_info_list_bloc.dart';

@immutable
abstract class TourInfoListState {
  @override
  String toString() => runtimeType.toString();
}

class TourInfoListInitial extends TourInfoListState {}

class TourInfoListStateLoading extends TourInfoListState {}

class TourInfoListStateSuccess extends TourInfoListState {
  final Pagination<Place> placeList;

  TourInfoListStateSuccess(this.placeList);

  @override
  String toString() => '$runtimeType ${placeList.data.length}';
}

class TourInfoListStateFailure extends TourInfoListState {
  final dynamic error;

  TourInfoListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
