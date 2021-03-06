part of repo;

class _AuthRepository {
  final AuthProvider _authProvider = AuthProvider();
  final StorageProvider _storageProvider = StorageProvider();

  String _token = '';

  Future<String> get token async {
    if (!_token.isExistAndNotEmpty) {
      _token = await _storageProvider.read(StorageKey.Token.toString());
      if (_token != null) debugPrint('\x1B[94m' + _token + '\x1B[0m');
    }
    return _token;
  }

  Future<bool> get isAuth async => (await token).isExistAndNotEmpty;

  Future<void> login(String email, String password) async {
    final authResponse = await _authProvider.login(email, password);
    await _saveAuth(authResponse.token);
  }

  Future<void> loginFacebook(String accessToken, [String email]) async {
    print('Facebook token: $accessToken');
    final authResponse = await _authProvider.loginFacebook(accessToken, email);
    await _saveAuth(authResponse.token);
  }

  Future<void> register({
    @required String name,
    @required String email,
    @required String phoneNumber,
    @required String password,
  }) async {
    final authResponse = await _authProvider.register(
      email: email,
      name: name,
      password: password,
      phoneNumber: phoneNumber,
    );
    await _saveAuth(authResponse.token);
  }

  Future logout() async {
    await _authProvider.logout();
    await _removeAuth();
  }

  Future _saveAuth(String token) async {
    await Future.wait([
      _storageProvider.save(StorageKey.Token.toString(), token),
    ]);

    print('Token: $token');
    _token = token;
  }

  Future _removeAuth() async {
    await Future.wait([
      _storageProvider.delete(StorageKey.Token.toString()),
    ]);

    _token = '';
  }
}
