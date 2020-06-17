part of 'tour_reviews_bloc.dart';

@immutable
abstract class TourReviewsState {
  @override
  String toString() => runtimeType.toString();
}

class TourReviewsInitial extends TourReviewsState {}

class TourReviewsStateLoading extends TourReviewsState {}

class TourReviewsStateSuccess extends TourReviewsState {
  final Pagination<Post> reviews;

  TourReviewsStateSuccess(this.reviews);

  @override
  String toString() =>
      '$runtimeType ${reviews.data.length} / ${reviews.pagination.totalPage}';
}

class TourReviewsStateFailure extends TourReviewsState {
  final dynamic error;

  TourReviewsStateFailure(this.error);

  @override
  String toString() => '$runtimeType $error';
}
