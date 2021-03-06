part of providers;

class UserProvider {
  final _client = ApiClient();

  Future<User> getMe() async {
    final result = await _client.connect<User>(ApiMethod.GET, Api.me);
    return result;
  }

  Future<User> getUserInfo(int userId) async {
    final result =
        await _client.connect<User>(ApiMethod.GET, Api.userInfo(userId));
    return result;
  }

  Future<Pagination<SimpleUser>> getMeFriends(FriendType type,
      {int page = 1, int pageSize = 10}) async {
    if (type == FriendType.none) {
      type = FriendType.accepted;
    }

    final response =
        await _client.normalConnect(ApiMethod.GET, Api.meFriends, query: {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'type': enumToString(type ?? FriendType.accepted),
    });

    return Pagination(response.data['Pagination'], response.data['Data']);
  }

  ///
  /// [userId == 0] => me
  Future<Pagination<SimpleUser>> getUserFriends(int userId,
      [int page = 1, int pageSize = 10]) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meFriends : Api.userFriends(userId),
        query: {'page': page.toString(), 'pageSize': pageSize.toString()});

    return Pagination(response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<SimpleTour>> getMeTours(
    int page,
    int pageSize,
    String keyword,
    MeTourType type,
  ) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.meTours, query: {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      if (keyword.isExistAndNotEmpty) 'keyword': keyword,
      if (type != null) 'type': enumToString(type),
    });

    return Pagination(response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<SimpleTour>> getUserTours(
      int userId, int page, int pageSize, String keyword) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meTours : Api.userTours(userId),
        query: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          if (keyword.isExistAndNotEmpty) 'keyword': keyword,
        });

    return Pagination(response.data['Pagination'], response.data['Data']);
  }

  Future<User> updateProfile(UserToPut userToPut) async {
    String avatar;
    if (userToPut.avatar != null) {
      final system = SystemProvider();
      avatar = await system.uploadImage(userToPut.avatar);
    }

    final result = await _client.connect<User>(ApiMethod.PUT, Api.me, body: {
      ...userToPut.toJson(),
      if (avatar != null) ...{'avatar': avatar}
    });
    return result;
  }

  Future addFriend(int userId) async {
    await _client.normalConnect(ApiMethod.POST, Api.addFriend(userId));
  }

  Future removeFriend(int userId) async {
    await _client.normalConnect(ApiMethod.DELETE, Api.deleteFriend(userId));
  }

  Future acceptFriend(int userId) async {
    await _client.normalConnect(ApiMethod.POST, Api.acceptFriend(userId));
  }

  Future<Pagination<SimpleUser>> getTopUsers(
      {int page = 1, int pageSize = 10}) async {
    // Todo change api
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.topUser, query: {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'type': enumToString(FriendType.accepted),
    });

    return Pagination(response.data['Pagination'], response.data['Data']);
  }
}
