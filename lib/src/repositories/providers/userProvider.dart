part of providers;

class UserProvider {
  final _client = ApiClient();

  Future<User> getMe() async {
    final result = await _client.connect<User>(ApiMethod.GET, Api.me);
    return result;
  }

  Future<List<User>> getUserFriends(int userId) async {
    final response = await _client.normalConnect(
        ApiMethod.GET, userId == 0 ? Api.meFriends : Api.userFriends(userId));
    return (response.data['Data'] as List)
        .map((e) => Mapper.fromJson(e).toObject<User>())
        .toList();
  }
}
