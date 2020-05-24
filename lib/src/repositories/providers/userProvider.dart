part of providers;

class UserProvider {
  final _client = ApiClient();

  Future<User> getMe() async {
    final result = await _client.connect<User>(ApiMethod.GET, Api.me);
    return result;
  }

  Future<User> getUserInfo(int userId) async {
    final result = await _client.connect<User>(ApiMethod.GET, Api.userInfo(userId));
    return result;
  }

  Future<List<SimpleUser>> getUserFriends(int userId) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meFriends : Api.userFriends(userId));
    return (response.data['Data'] as List)
        .map((e) => Mapper.fromJson(e).toObject<SimpleUser>())
        .toList();
  }

  Future<List<SimpleTour>> getUserTours(int userId) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meTours : Api.userTours(userId));
    return (response.data['Data'] as List)
        .map((e) => Mapper.fromJson(e).toObject<SimpleTour>())
        .toList();
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
