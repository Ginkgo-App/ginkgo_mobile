import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';
import 'package:base/base.dart';

part 'place_list_event.dart';
part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  PlaceListBloc(this.pageSize);

  final Repository _repository = Repository();
  final int pageSize;
  static List<Place> _allPlaceFirstPage;
  static List<Place> get allPlace => _allPlaceFirstPage;

  String _keyword;
  Pagination<Place> _placeList = Pagination();
  Pagination<Place> get placeList => _placeList;

  @override
  PlaceListState get initialState => PlaceListInitial();

  @override
  Stream<PlaceListState> mapEventToState(PlaceListEvent event) async* {
    try {
      if (event is PlaceListEventFetch) {
        if(!_placeList.canLoadmore && _keyword == event.keyword) return;
        
        yield PlaceListStateLoading();

        int nextPage = _placeList.pagination.currentPage + 1;
        if (event.keyword.isExistAndNotEmpty && _keyword != event.keyword) {
          _keyword = event.keyword;
          nextPage = 1;
        }

        _placeList.add(await _repository.place.getList(
          type: event.type,
          pageSize: pageSize,
          page: nextPage,
          keyword: _keyword,
        ));

        if (event.type == null &&
            _placeList.pagination.currentPage == 1 &&
            !event.keyword.isExistAndNotEmpty) {
          _allPlaceFirstPage = _placeList.data;
        }

        yield PlaceListStateSuccess(_placeList);
      } else if (event is PlaceListEventFetchBestList) {
        yield PlaceListStateLoading();

        final data = await _repository.place.getList(
          pageSize: pageSize,
          page: _placeList.pagination.currentPage + 1,
        );

        yield PlaceListStateSuccess(data);
      }
    } catch (e) {
      yield PlaceListStateFailure(e);
    }
  }
}
