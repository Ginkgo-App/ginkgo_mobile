import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'post_comment_event.dart';
part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  final Repository _repository = Repository();

  @override
  PostCommentState get initialState => PostCommentInitial();

  @override
  Stream<PostCommentState> mapEventToState(
    PostCommentEvent event,
  ) async* {
    try {
      if (event is PostCommentEventCreatePost) {
        yield PostCommentStateLoading();
        yield PostCommentStatePostSuccess(
          await _repository.post.create(event.postToPost),
        );
      } else if (event is PostCommentEventCreateComment) {
        yield PostCommentStateLoading();
        yield PostCommentStateCommentSuccess(
          await _repository.post.comment(event.commentToPost),
        );
      }
    } catch (e) {
      yield PostCommentStateFailure(e);
    }
  }
}
