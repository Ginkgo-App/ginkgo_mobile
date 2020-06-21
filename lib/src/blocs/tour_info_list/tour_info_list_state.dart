part of 'tour_info_list_bloc.dart';

@immutable
abstract class TourInfoListState {
  @override
  String toString() => runtimeType.toString();
}

class TourInfoListInitial extends TourInfoListState {}

class TourInfoListStateLoading extends TourInfoListState {}

class TourInfoListStateSuccess extends TourInfoListState {
  final Pagination<TourInfo> tourInfoList;

  TourInfoListStateSuccess(this.tourInfoList);

  @override
  String toString() =>
      '$runtimeType ${tourInfoList.data.length} / ${tourInfoList.pagination.totalPage}';
}

class TourInfoListStateFailure extends TourInfoListState {
  final dynamic error;

  TourInfoListStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
