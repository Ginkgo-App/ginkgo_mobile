import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_detail_event.dart';
part 'tour_detail_state.dart';

class TourDetailBloc extends Bloc<TourDetailEvent, TourDetailState> {
  final Repository _repository = Repository();

  Tour _tour;

  Tour get tour => _tour;

  @override
  TourDetailState get initialState => TourDetailInitial();

  @override
  Stream<TourDetailState> mapEventToState(
    TourDetailEvent event,
  ) async* {
    if (event is TourDetailEventFetch) {
      try {
        yield TourDetailStateLoading();

        _tour = await _repository.tour.getDetail(event.tourId);

        yield TourDetailStateSuccess();
      } catch (e) {
        yield TourDetailStateFailure(e);
      }
    }
  }
}
