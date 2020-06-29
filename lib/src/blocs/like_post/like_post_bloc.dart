import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'like_post_event.dart';
part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  static LikePostBloc _instance = LikePostBloc._();
  LikePostBloc._();
  factory LikePostBloc() => _instance;

  final Repository _repository = Repository();

  @override
  Future<void> close() {
    _instance.close();
    return super.close();
  }

  @override
  LikePostState get initialState => LikePostInitial();

  @override
  Stream<LikePostState> mapEventToState(
    LikePostEvent event,
  ) async* {
    if (event is LikePostEventLike) {
      try {
        yield LikePostStateLoading(event.postId, true);
        await _repository.post.like(event.postId, true);
        yield LikePostStateSuccess(event.postId);
      } catch (e) {
        yield LikePostStateFailure(e, event.postId, true);
      }
    } else if (event is LikePostEventUnlike) {
      try {
        yield LikePostStateLoading(event.postId, false);
        await _repository.post.like(event.postId, false);
        yield LikePostStateSuccess(event.postId);
      } catch (e) {
        yield LikePostStateFailure(e, event.postId, false);
      }
    }
  }
}
