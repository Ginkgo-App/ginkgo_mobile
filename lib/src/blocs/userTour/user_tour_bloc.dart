import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'user_tour_event.dart';
part 'user_tour_state.dart';

class UserTourBloc extends Bloc<UserTourEvent, UserTourState> {
  final Repository _repository = Repository();

  @override
  UserTourState get initialState => UserTourInitial();

  @override
  Stream<UserTourState> mapEventToState(
    UserTourEvent event,
  ) async* {
    try {
      if (event is UserTourEventFetch) {
        yield UserTourLoading();
        final _tours = await _repository.user.getUserTours(event.userId);
        yield UserTourSuccess(_tours);
      }
    } catch (e) {
      yield UserTourFailure(e.toString());
    }
  }
}
