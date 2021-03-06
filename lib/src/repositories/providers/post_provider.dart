part of providers;

class PostProvider {
  final _client = ApiClient();

  Future<int> create(PostToPost post) async {
    final List<String> images = [];

    if (post.images.length > 0) {
      final system = SystemProvider();
      images.addAll(
        await Future.wait(
          post.images.map((i) => system.uploadImage(i)).toList(),
        ),
      );
    }

    final response = await _client.normalConnect(
      ApiMethod.POST,
      Api.posts(null),
      body: {
        'Content': post.content,
        'Images': images,
        'TourId': post.tourId,
        'Rating': post.rating,
      },
    );

    try {
      return response.data['Data'][0]['Id'];
    } catch (e) {
      throw e;
    }
  }

  Future like(int postId, bool isLike) async {
    await _client.normalConnect(
      isLike ? ApiMethod.POST : ApiMethod.DELETE,
      Api.posts(postId) + '/like',
    );
  }

  Future delete(int postId) async {
    await _client.normalConnect(ApiMethod.DELETE, Api.posts(postId));
  }

  Future<Comment> comment(CommentToPost comment) async {
    final result = await _client.connect<Comment>(
      ApiMethod.POST,
      Api.posts(comment.postId) + '/comments',
      body: {
        'Content': comment.content,
      },
    );

    return result;
  }

  Future<Pagination<Post>> getList({int page, int pageSize}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.posts(null), query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
    });

    return Pagination<Post>(response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<Comment>> getCommentList(int postId,
      {int page, int pageSize}) async {
    final response = await _client
        .normalConnect(ApiMethod.GET, Api.posts(postId) + '/comments', query: {
      'page': (page ?? 1).toString(),
      'pageSize': pageSize?.toString() ?? 0,
    });

    return Pagination<Comment>(
        response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<Post>> getUserPosts(
      int userId, int page, int pageSize) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.mePosts : Api.userPosts(userId),
        query: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
        });

    return Pagination(response.data['Pagination'], response.data['Data']);
  }
}
