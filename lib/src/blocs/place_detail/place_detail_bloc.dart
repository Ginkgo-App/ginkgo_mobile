import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'place_detail_event.dart';
part 'place_detail_state.dart';

class PlaceDetailBloc extends Bloc<PlaceDetailEvent, PlaceDetailState> {
  final Repository _repository = Repository();

  Place _place;

  Place get place => _place;

  @override
  PlaceDetailState get initialState => PlaceDetailInitial();

  @override
  Stream<PlaceDetailState> mapEventToState(
    PlaceDetailEvent event,
  ) async* {
    if (event is PlaceDetailEventFetch) {
      try {
        yield PlaceDetailStateLoading();

        _place = await _repository.place.getDetail(event.placeId);

        yield PlaceDetailStateSuccess();
      } catch (e) {
        yield PlaceDetailStateFailure(e);
      }
    }
  }
}
