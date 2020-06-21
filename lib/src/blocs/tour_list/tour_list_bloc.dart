import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_list_event.dart';
part 'tour_list_state.dart';

class TourListBloc extends Bloc<TourListEvent, TourListState> {
  final Repository _repository = Repository();
  final int pageSize;
  final TourListType tourListType; // Để get các list ngoài trang chủ
  final int userId;
  final MeTourType meType; // Để get các list khác nhau của mình

  String _keyword;

  Pagination<SimpleTour> _tourList = Pagination<SimpleTour>();

  Pagination<SimpleTour> get tourList => _tourList;

  TourListBloc(this.pageSize, {this.tourListType, this.userId, this.meType});

  @override
  TourListState get initialState => TourListInitial();

  @override
  Stream<TourListState> mapEventToState(
    TourListEvent event,
  ) async* {
    try {
      if (event is TourListEventFetch && _tourList.canLoadmore) {
        yield TourListStateLoading();

        int _nextPage = _tourList.pagination.currentPage + 1;
        if (event.keyword != null && _keyword != event.keyword) {
          _keyword = event.keyword;
          _nextPage = 1;
        }

        _tourList.add(
          userId != null
              ? (userId == 0
                  ? await _repository.user.getMeTours(
                      page: _nextPage,
                      pageSize: pageSize,
                      keyword: _keyword,
                      type: meType,
                    )
                  : await _repository.user.getUserTours(
                      userId: userId,
                      page: _nextPage,
                      pageSize: pageSize,
                      keyword: _keyword,
                    ))
              : await _repository.tour.getList(
                  pageSize: pageSize,
                  page: _nextPage,
                  keyword: _keyword,
                ),
        );

        yield TourListStateSuccess(_tourList);
      }
    } catch (e) {
      yield TourListStateFailure(e);
    }
  }
}
