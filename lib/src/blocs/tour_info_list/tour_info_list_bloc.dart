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
  final int _userId;
  String _keyword;

  Pagination<TourInfo> _tourInfoList = Pagination<TourInfo>();

  Pagination<TourInfo> get tourInfoList => _tourInfoList;

  TourInfoListBloc(this._pageSize, {int userId}) : _userId = userId;

  @override
  TourInfoListState get initialState => TourInfoListInitial();

  @override
  Stream<TourInfoListState> mapEventToState(
    TourInfoListEvent event,
  ) async* {
    try {
      if (event is TourInfoListEventFetch && _tourInfoList.canLoadmore) {
        yield TourInfoListStateLoading();

        int nextPage = _tourInfoList.pagination.currentPage + 1;
        if (_keyword != event.keyword && event.keyword != null) {
          _keyword = event.keyword;
          nextPage = 1;
        }

        _tourInfoList.add(_userId != null
            ? await _repository.tourInfo.getListOfUser(
                _userId,
                page: nextPage,
                pageSize: _pageSize,
                keyword: event.keyword,
              )
            : await _repository.tourInfo.getList(
                page: nextPage,
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
