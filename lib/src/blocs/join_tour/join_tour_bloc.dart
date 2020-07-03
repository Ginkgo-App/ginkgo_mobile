import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'join_tour_event.dart';
part 'join_tour_state.dart';

class JoinTourBloc extends Bloc<JoinTourEvent, JoinTourState> {
  static JoinTourBloc _instance = JoinTourBloc._();
  JoinTourBloc._();
  factory JoinTourBloc() => _instance;

  final Repository _repository = Repository();

  @override
  Future<void> close() {
    _instance.close();
    return super.close();
  }

  @override
  JoinTourState get initialState => JoinTourInitial();

  @override
  Stream<JoinTourState> mapEventToState(
    JoinTourEvent event,
  ) async* {
    if (event is JoinTourEventJoint) {
      try {
        yield JoinTourStateLoading(event.tourId);
        await _repository.tour.join(event.tourId);
        yield JoinTourStateSuccess(event.tourId, false);
      } catch (e) {
        yield JoinTourStateFailure(e, event.tourId);
      }
    } else if (event is JoinTourEventLeave) {
      try {
        yield JoinTourStateLoading(event.postId);
        await _repository.tour.leave(event.postId);
        yield JoinTourStateSuccess(event.postId, true);
      } catch (e) {
        yield JoinTourStateFailure(e, event.postId);
      }
    }
  }
}
