part of repo;

class _PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<int> create(PostToPost postToPost) => _postProvider.create(postToPost);

  Future<Comment> comment(CommentToPost commentToPost) =>
      _postProvider.comment(commentToPost);

  Future like(int postId, bool isLike) => _postProvider.like(postId, isLike);

  Future delete(int postId) => _postProvider.delete(postId);

  Future<Pagination<Post>> getList({int page, int pageSize}) =>
      _postProvider.getList(page: page, pageSize: pageSize);

  Future<Pagination<Comment>> getCommentList(int postId,
          {int page, int pageSize}) =>
      _postProvider.getCommentList(postId, page: page, pageSize: pageSize);

  Future<Pagination<Post>> getUserPosts({int userId, int page, int pageSize}) =>
      _postProvider.getUserPosts(userId, page, pageSize);
}
