import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/blocs/like_post/like_post_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/post_comment/post_comment_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:meta/meta.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostCommentBloc postCommentBloc = PostCommentBloc();
  Post _post;
  Post get post => _post;
  StreamSubscription _listener;

  PostDetailBloc(this._post) : assert(_post != null) {
    _listener = LikePostBloc().listen((state) {
      if (state is LikePostStateLoading && state.postId == _post.id) {
        this.add(PostDetailEventChangeLike(isIncrease: state.isLiked));
      } else if (state is LikePostStateFailure && state.postId == _post.id) {
        this.add(PostDetailEventChangeLike(isIncrease: !state.isLiked));
      }
    });

    postCommentBloc.listen((state) {
      if (state is PostCommentStateCommentSuccess) {
        this.add(PostDetailEventChangeComment(isIncrease: true));
      }
    });
  }

  @override
  PostDetailState get initialState => PostDetailInitial();

  @override
  Future<void> close() {
    postCommentBloc.close();
    _listener.cancel();
    return super.close();
  }

  @override
  Stream<PostDetailState> mapEventToState(
    PostDetailEvent event,
  ) async* {
    if (event is PostDetailEventChangeLike) {
      _post.totalLike += (event.isIncrease ? 1 : -1);
      _post.isLiked = event.isIncrease;
      yield PostDetailStateHaveChange();
    } else if (event is PostDetailEventChangeComment) {
      _post.totalComment += (event.isIncrease ? 1 : -1);
      yield PostDetailStateHaveChange();
    }
  }
}
