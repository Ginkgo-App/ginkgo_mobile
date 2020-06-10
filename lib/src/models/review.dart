part of 'models.dart';

class Review {
  final String id;
  final User author;
  final DateTime createAt;
  final String content;
  final int totalLike;
  final int totalComment;
  final List<Comment> featuredComments;
  final int rating;
  final TourInfo tourInfo;

  Review({
    this.id,
    this.author,
    this.createAt,
    this.content,
    this.totalLike,
    this.totalComment,
    this.featuredComments,
    this.rating,
    this.tourInfo,
  });
}
