import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  CommentListBloc(this.pageSize, this.postId);

  final Repository _repository = Repository();
  final int pageSize;
  final int postId;

  Pagination<Comment> _commentList = Pagination();
  Pagination<Comment> get commentList => _commentList;

  @override
  CommentListState get initialState => CommentListInitial();

  @override
  Stream<CommentListState> mapEventToState(CommentListEvent event) async* {
    try {
      if (event is CallEventChangeState) {
        yield event.state;
      } else if (event is CommentListEventFetch) {
        _commentList = Pagination();
        yield CommentListStateLoading();

        int nextPage = _commentList.pagination.currentPage + 1;

        _commentList.add(await _repository.post.getCommentList(
          postId,
          pageSize: pageSize,
          page: nextPage,
        ));

        yield CommentListStateSuccess(_commentList);
      } else if (event is CommentListEventLoadMore &&
          _commentList.canLoadmore &&
          (state is! CommentListStateFailure || event.force)) {
        yield CommentListStateLoading(isLoadMore: true);

        _commentList.add(await _repository.post.getCommentList(
          postId,
          pageSize: pageSize,
          page: _commentList.pagination.currentPage + 1,
        ));

        yield CommentListStateSuccess(_commentList);
      } else {
        // Reload comment
        Timer.periodic(Duration(seconds: 5), (timer) async {
          _commentList.add(await _repository.post.getCommentList(
            postId,
            pageSize: pageSize,
            page: _commentList.pagination.currentPage,
          ));

          debugPrint("reset list");

          // Call init before change
          add(CallEventChangeState(CommentListInitial()));
          add(CallEventChangeState(CommentListStateSuccess(_commentList)));
        });
      }
    } catch (e) {
      yield CommentListStateFailure(e);
    }
  }
}
