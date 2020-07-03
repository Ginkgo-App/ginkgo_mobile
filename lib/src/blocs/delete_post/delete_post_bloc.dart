import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  static DeletePostBloc _instance = DeletePostBloc._();
  DeletePostBloc._();
  factory DeletePostBloc() => _instance;

  final Repository _repository = Repository();

  @override
  Future<void> close() {
    _instance.close();
    return super.close();
  }

  @override
  DeletePostState get initialState => DeletePostInitial();

  @override
  Stream<DeletePostState> mapEventToState(
    DeletePostEvent event,
  ) async* {
    if (event is DeletePostEventDelete) {
      try {
        yield DeletePostStateLoading(event.postId);
        await _repository.post.delete(event.postId);
        yield DeletePostStateSuccess(event.postId);
      } catch (e) {
        yield DeletePostStateFailure(e, event.postId);
      }
    }
  }
}
