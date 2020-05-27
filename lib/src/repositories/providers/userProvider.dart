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
      [int page = 1, int pageSize = 10]) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.meFriends, query: {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      'type': enumToString(type ?? FriendType.none)
    });

    return Pagination(response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<SimpleUser>> getUserFriends(int userId,
      [int page = 1, int pageSize = 10]) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meFriends : Api.userFriends(userId),
        query: {'page': page.toString(), 'pageSize': pageSize.toString()});

    return Pagination(response.data['Pagination'], response.data['Data']);
  }

  Future<Pagination<SimpleTour>> getUserTours(int userId) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meTours : Api.userTours(userId));

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
}
