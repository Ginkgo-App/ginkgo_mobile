part of repo;

class _PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<int> create(PostToPost postToPost) => _postProvider.create(postToPost);

  Future<Comment> comment(CommentToPost commentToPost) =>
      _postProvider.comment(commentToPost);
}
