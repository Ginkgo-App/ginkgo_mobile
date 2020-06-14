import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_info_list_event.dart';
part 'tour_info_list_state.dart';

class TourInfoListBloc extends Bloc<TourInfoListEvent, TourInfoListState> {
  final Repository _repository = Repository();
  final int _pageSize;

  Pagination<TourInfo> _tourInfoList = Pagination<TourInfo>();

  Pagination<TourInfo> get tourInfoList => _tourInfoList;

  TourInfoListBloc(this._pageSize);

  @override
  TourInfoListState get initialState => TourInfoListInitial();

  @override
  Stream<TourInfoListState> mapEventToState(
    TourInfoListEvent event,
  ) async* {
    try {
      if (event is TourInfoListEventFetch && _tourInfoList.canLoadmore) {
        yield TourInfoListStateLoading();

        _tourInfoList.add(await _repository.tourInfo.getList(
          page: _tourInfoList.pagination.currentPage + 1,
          pageSize: _pageSize,
          keyword: event.keyword,
        ));

        yield TourInfoListStateSuccess(_tourInfoList);
      }
    } catch (e) {
      yield TourInfoListStateFailure(e);
    }
  }
}
