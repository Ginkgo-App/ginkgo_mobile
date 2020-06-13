import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_info_detail_event.dart';
part 'tour_info_detail_state.dart';

const _PAGE_SIZE = 10;

class TourInfoDetailBloc
    extends Bloc<TourInfoDetailEvent, TourInfoDetailState> {
  final Repository _repository = Repository();

  TourInfo _tourInfo;
  Pagination<SimpleTour> _tourList;

  TourInfo get tourInfo => _tourInfo;
  Pagination<SimpleTour> get tourList => _tourList;

  @override
  TourInfoDetailState get initialState => TourInfoDetailInitial();

  @override
  Stream<TourInfoDetailState> mapEventToState(
    TourInfoDetailEvent event,
  ) async* {
    if (event is TourInfoDetailEventFetch) {
      try {
        yield TourInfoDetailStateLoading();

        final data = await Future.wait([
          _repository.tourInfo.getDetail(event.tourInfoId),
          _repository.tourInfo
              .getTourList(event.tourInfoId, page: 1, pageSize: _PAGE_SIZE),
        ]);

        _tourInfo = data[0];
        _tourList = data[1];

        yield TourInfoDetailStateSuccess();
      } catch (e) {
        yield TourInfoDetailStateFailure(e);
        print(e.stackTrace);
      }
    } else if (event is TourInfoDetailEventLoadMore &&
        _tourInfo != null &&
        _tourList != null &&
        !_tourList.canLoadmore) {
      try {
        yield TourInfoDetailStateLoadingMore();

        _tourList.add(await _repository.tourInfo.getTourList(_tourInfo.id,
            page: _tourList.pagination.currentPage + 1, pageSize: _PAGE_SIZE));

        yield TourInfoDetailStateLoadMoreSuccess();
      } catch (e) {
        yield TourInfoDetailStateLoadMoreFailure(e);
      }
    }
  }
}
