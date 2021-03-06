import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'create_tour_event.dart';
part 'create_tour_state.dart';

class CreateTourBloc extends Bloc<CreateTourEvent, CreateTourState> {
  final Repository _repository = Repository();
  @override
  CreateTourState get initialState => CreateTourInitial();

  TourToPost _tourToPost = TourToPost();
  TourToPost get tourToPost => _tourToPost;

  @override
  Stream<CreateTourState> mapEventToState(
    CreateTourEvent event,
  ) async* {
    try {
      if (event is CreateTourEventChangeData) {
        _tourToPost.update(event.tourToPost);
        yield CreateTourStateHaveChanged(event.validation, _tourToPost);
      } else if (event is CreateTourEventCreate) {
        yield CreateTourStateLoading();
        yield CreateTourStateSuccess(
            await _repository.tour.create(_tourToPost));
      }
    } catch (e) {
      yield CreateTourStateFailure(e);
    }
  }
}
