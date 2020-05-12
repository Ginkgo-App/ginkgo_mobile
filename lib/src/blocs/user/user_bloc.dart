import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository _repository = Repository();

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    try {
      if (event is UserEventFetch) {
        yield UserStateLoading();
        final user = await _repository.user.getMe();
        yield UserStateSuccess(user);
      }
    } catch (e) {
      yield UserStateFailure(e.toString());
    }
  }
}
