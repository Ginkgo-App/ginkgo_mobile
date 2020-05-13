import 'package:ginkgo_mobile/src/models/comment.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

class Post {
  final String id;
  final User author;
  final DateTime createAt;
  final String content;
  final List<String> images;
  final int totalLike;
  final int totalComment;
  final List<Comment> featuredComments;
  final int rating;

  Post({
    this.id,
    this.author,
    this.createAt,
    this.content,
    this.images,
    this.totalLike,
    this.totalComment,
    this.featuredComments,
    this.rating,
  });
}

enum PostType { normal, image, images, tour }
