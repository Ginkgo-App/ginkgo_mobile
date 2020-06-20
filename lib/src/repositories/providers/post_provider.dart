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
      Api.tourInfos(null),
      body: {
        'Content': post.content,
        'Images': images,
        'TourId': post.tourId,
        'Rating': post.rating,
      },
    );

    try {
      return response.data['Data'][0];
    } catch (e) {
      throw response.data;
    }
  }

  Future<Comment> comment(CommentToPost comment) async {
    final result = await _client.connect<Comment>(
      ApiMethod.POST,
      Api.posts(comment.postId),
      body: {
        'Content': comment.content,
      },
    );

    return result;
  }
}
