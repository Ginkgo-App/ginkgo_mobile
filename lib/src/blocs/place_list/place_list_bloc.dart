import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:meta/meta.dart';

part 'place_list_event.dart';
part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  @override
  PlaceListState get initialState => PlaceListInitial();

  @override
  Stream<PlaceListState> mapEventToState(
    PlaceListEvent event,
  ) async* {
    try {
      if (event is PlaceListEventFetch) {
        yield PlaceListStateLoading();
        await Future.delayed(Duration(seconds: 2));

        final totalElement = Random().nextInt(30);
        final data = Pagination<Place>.dev(
          data: List.generate(totalElement, (index) => FakeData.place),
          totalPage: 1,
          totalElement: totalElement,
          currentPage: 1,
          pageSize: totalElement,
        );

        yield PlaceListStateSuccess(data);
      }
    } catch (e) {
      yield PlaceListStateFailure(e);
    }
  }
}
