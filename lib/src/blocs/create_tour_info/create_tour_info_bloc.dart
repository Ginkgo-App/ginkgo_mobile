import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'create_tour_info_event.dart';
part 'create_tour_info_state.dart';

class CreateTourInfoBloc
    extends Bloc<CreateTourInfoEvent, CreateTourInfoState> {
  final Repository _repository = Repository();

  @override
  CreateTourInfoState get initialState => CreateTourInfoInitial();

  @override
  Stream<CreateTourInfoState> mapEventToState(
    CreateTourInfoEvent event,
  ) async* {
    try {
      if (event is CreateTourInfoEventCreate) {
        yield CreateTourInfoStateLoading();
        yield CreateTourInfoStateSuccess(
            await _repository.tourInfo.create(event.tourInfoToPost));
      }
    } catch (e) {
      yield CreateTourInfoStateFailure(e);
    }
  }
}
