part of repo;

class _UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> getMe() => _userProvider.getMe();

  Future<User> getUserInfo(int userId) => _userProvider.getUserInfo(userId);

  Future<List<SimpleUser>> getUserFriends(int userId) =>
      _userProvider.getUserFriends(userId);

  Future<List<SimpleTour>> getUserTours(int userId) =>
      _userProvider.getUserTours(userId);

  Future<User> updateProfile(UserToPut userToPut) =>
      _userProvider.updateProfile(userToPut);
}
