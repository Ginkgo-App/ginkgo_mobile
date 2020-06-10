import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'place_list_event.dart';
part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final Repository _repository = Repository();

  @override
  PlaceListState get initialState => PlaceListInitial();

  @override
  Stream<PlaceListState> mapEventToState(PlaceListEvent event) async* {
    try {
      if (event is PlaceListEventFetch) {
        yield PlaceListStateLoading();
        await Future.delayed(Duration(seconds: 2));

        final data = await _repository.place.getList(
            type: event.type,
            pageSize: event.pageSize,
            page: event.page,
            keyword: event.keyword);

        yield PlaceListStateSuccess(data);
      }
    } catch (e) {
      yield PlaceListStateFailure(e);
    }
  }
}
