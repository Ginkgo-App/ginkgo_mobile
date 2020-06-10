import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';
import 'package:base/base.dart';

part 'place_list_event.dart';
part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final Repository _repository = Repository();

  static List<Place> _allPlace;
  static List<Place> get allPlace => _allPlace;

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

        if (event.type == null &&
            event.pageSize == 0 &&
            !event.keyword.isExistAndNotEmpty) {
          _allPlace = data.data;
        }

        yield PlaceListStateSuccess(data);
      }
    } catch (e) {
      yield PlaceListStateFailure(e);
    }
  }
}
