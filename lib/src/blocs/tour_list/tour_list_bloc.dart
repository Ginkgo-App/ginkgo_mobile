import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_list_event.dart';
part 'tour_list_state.dart';

class TourListBloc extends Bloc<TourListEvent, TourListState> {
  final Repository _repository = Repository();
  final int _pageSize;

  Pagination<SimpleTour> _tourList = Pagination<SimpleTour>();

  Pagination<SimpleTour> get tourList => _tourList;

  TourListBloc(this._pageSize);

  @override
  TourListState get initialState => TourListInitial();

  @override
  Stream<TourListState> mapEventToState(
    TourListEvent event,
  ) async* {
    try {
      if (event is TourListEventFetchOfUser && _tourList.canLoadmore) {
        yield TourListStateLoading();
        _tourList.add(await _repository.user.getUserTours(
            userId: event.userId,
            page: _tourList.pagination.currentPage + 1,
            pageSize: _pageSize,
            keyword: event.keyword));

        yield TourListStateSuccess(_tourList);
      } else if (event is TourListEventFetchOfMe && _tourList.canLoadmore) {
        yield TourListStateLoading();
        _tourList.add(
          await _repository.user.getMeTours(
            page: _tourList.pagination.currentPage + 1,
            pageSize: _pageSize,
            keyword: event.keyword,
            type: event.type,
          ),
        );

        yield TourListStateSuccess(_tourList);
      } else if (event is TourListEventFetch && _tourList.canLoadmore) {
        yield TourListStateLoading();

        _tourList.add(await _repository.tour.getList(
            pageSize: _pageSize,
            page: _tourList.pagination.currentPage + 1,
            keyword: event.keyword));

        yield TourListStateSuccess(_tourList);
      }
    } catch (e) {
      yield TourListStateFailure(e);
    }
  }
}
