part of repo;

class _UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> getMe() => _userProvider.getMe();

  Future<User> getUserInfo(int userId) => _userProvider.getUserInfo(userId);

  Future<Pagination<SimpleUser>> getMeFriends(FriendType type,
          {int page = 1, int pageSize = 10}) =>
      _userProvider.getMeFriends(type, page: page, pageSize: pageSize);

  Future<Pagination<SimpleUser>> getUserFriends(int userId,
          {int page, int pageSize}) =>
      _userProvider.getUserFriends(userId, page, pageSize);

  Future<Pagination<SimpleTour>> getUserTours(
          {int userId, int page, int pageSize, String keyword}) =>
      _userProvider.getUserTours(userId, page, pageSize, keyword);

  Future<User> updateProfile(UserToPut userToPut) =>
      _userProvider.updateProfile(userToPut);

  Future addFriend(int userId) => _userProvider.addFriend(userId);

  Future removeFriend(int userId) => _userProvider.removeFriend(userId);

  Future acceptFriend(int userId) => _userProvider.acceptFriend(userId);
}
