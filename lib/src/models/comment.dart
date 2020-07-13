part of 'models.dart';

class Comment with Mappable {
  int id;
  User author;
  String content;
  DateTime createAt;

  Comment({this.id, this.author, this.createAt, this.content});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Author', author, (v) => author = Mapper.fromJson(v).toObject<User>());
    map('Content', content, (v) => content = v);
    map('CreateAt', createAt, (v) => createAt = v, DateTimeTransform());
  }
}

class CommentToPost {
  final int postId;
  final String content;

  CommentToPost(this.postId, {@required this.content});
}
