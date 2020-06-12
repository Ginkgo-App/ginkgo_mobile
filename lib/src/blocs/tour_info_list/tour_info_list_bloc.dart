import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_info_list_event.dart';
part 'tour_info_list_state.dart';

class TourInfoListBloc extends Bloc<TourInfoListEvent, TourInfoListState> {
  final Repository _repository = Repository();
  
  @override
  TourInfoListState get initialState => TourInfoListInitial();

  @override
  Stream<TourInfoListState> mapEventToState(
    TourInfoListEvent event,
  ) async* {
    try {
      if (event is TourInfoListEventFetch) {
        yield TourInfoListStateLoading();

        final data = await _repository.tourInfo.getList(
            pageSize: event.pageSize,
            page: event.page,
            keyword: event.keyword);

        yield TourInfoListStateSuccess(data);
      }
    } catch (e) {
      yield TourInfoListStateFailure(e);
    }
  }
}
