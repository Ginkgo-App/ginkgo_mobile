part of repo;

class _UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> getMe() => _userProvider.getMe();

  Future<List<User>> getUserFriends(int userId) => _userProvider.getUserFriends(userId);
}
