part of repo;

class _UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> getMe() => _userProvider.getMe();

  Future<List<SimpleUser>> getUserFriends(int userId) => _userProvider.getUserFriends(userId);

  Future<List<SimpleTour>> getUserTours(int userId) => _userProvider.getUserTours(userId);
}
