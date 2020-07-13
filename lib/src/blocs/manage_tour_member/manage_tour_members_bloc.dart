import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'manage_tour_members_event.dart';
part 'manage_tour_members_state.dart';

class ManageTourMembersBloc
    extends Bloc<ManageTourMembersEvent, ManageTourMembersState> {
  static ManageTourMembersBloc _instance = ManageTourMembersBloc._();
  ManageTourMembersBloc._();
  factory ManageTourMembersBloc() => _instance;

  final Repository repository = Repository();

  @override
  ManageTourMembersState get initialState => ManageTourMembersInitial();

  @override
  Stream<ManageTourMembersState> mapEventToState(
    ManageTourMembersEvent event,
  ) async* {
    if (event is ManageTourMembersEventAccept) {
      try {
        yield ManageTourMembersStateLoading(event.userId, event.tourId);
        await repository.tour.acceptMember(event.tourId, event.userId);
        yield ManageTourMembersStateSuccess(event.userId, event.tourId);
      } catch (e) {
        yield ManageTourMembersStateFailure(event.userId, e, event.tourId);
      }
    } else if (event is ManageTourMembersEventRemove) {
      try {
        yield ManageTourMembersStateLoading(event.userId, event.tourId);
        await repository.tour.removeMember(event.tourId, event.userId);
        yield ManageTourMembersStateSuccess(event.userId, event.tourId);
      } catch (e) {
        yield ManageTourMembersStateFailure(event.userId, e, event.tourId);
      }
    }
  }
}
