part of 'models.dart';

class Comment {
  final String id;
  final String postId;
  final User author;
  final String content;
  final DateTime createAt;

  Comment({this.id, this.postId, this.author, this.createAt, this.content});
}
