import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final Repository _repository = Repository();
  
  @override
  UpdateProfileState get initialState => UpdateProfileInitial();

  @override
  Stream<UpdateProfileState> mapEventToState(
    UpdateProfileEvent event,
  ) async* {
    if (event is UpdateProfileEventUpdate) {
      try {

      yield UpdateProfileStateLoading();
      await _repository.user.updateProfile(event.userToPut);
      yield UpdateProfileStateSuccess();
      } catch(e) {

      yield UpdateProfileStateFailure(e);
      }
    }
  }
}
