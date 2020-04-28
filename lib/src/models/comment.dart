import 'user.dart';

class Comment {
  final String id;
  final String postId;
  final User author;
  final String content;

  Comment({this.id, this.postId, this.author, this.content});
}
