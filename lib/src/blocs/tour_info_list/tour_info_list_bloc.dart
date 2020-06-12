import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:meta/meta.dart';

part 'tour_info_list_event.dart';
part 'tour_info_list_state.dart';

class TourInfoListBloc extends Bloc<TourInfoListEvent, TourInfoListState> {
  @override
  TourInfoListState get initialState => TourInfoListInitial();

  @override
  Stream<TourInfoListState> mapEventToState(
    TourInfoListEvent event,
  ) async* {
    try {
      if (event is TourInfoListEventFetch) {
        yield TourInfoListStateLoading();
        await Future.delayed(Duration(seconds: 2));

        final totalElement = Random().nextInt(30);
        final data = Pagination<Place>.dev(
          data: List.generate(totalElement, (index) => FakeData.place),
          totalPage: 1,
          totalElement: totalElement,
          currentPage: 1,
          pageSize: totalElement,
        );

        yield TourInfoListStateSuccess(data);
      }
    } catch (e) {
      yield TourInfoListStateFailure(e);
    }
  }
}
