import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'tour_reviews_event.dart';
part 'tour_reviews_state.dart';

class TourReviewsBloc extends Bloc<TourReviewsEvent, TourReviewsState> {
  final Repository _repository = Repository();
  final int _pageSize;

  Pagination<Post> _reviewList = Pagination<Post>();

  Pagination<Post> get reviewList => _reviewList;

  TourReviewsBloc(this._pageSize);

  @override
  TourReviewsState get initialState => TourReviewsInitial();

  @override
  Stream<TourReviewsState> mapEventToState(
    TourReviewsEvent event,
  ) async* {
    try {
      if (event is TourReviewsEventFetch && _reviewList.canLoadmore) {
        yield TourReviewsStateLoading();

        _reviewList.add(
          await _repository.tour.getReviews(
            event.tourId,
            pageSize: _pageSize,
            page: _reviewList.pagination.currentPage + 1,
          ),
        );

        yield TourReviewsStateSuccess(_reviewList);
      }
    } catch (e) {
      yield TourReviewsStateFailure(e);
    }
  }
}
