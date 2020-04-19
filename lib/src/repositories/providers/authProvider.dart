part of providers;

class AuthProvider {
  final _client = ApiClient();

  Future<String> login(String email, String password) async {
    // _client.normalConnect(ApiMethod.POST, Api.login);
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  Future<String> loginFacebook(String accessToken) async {
    // _client.normalConnect(ApiMethod.POST, Api.login);
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  Future logout() async {
    // _client.normalConnect(ApiMethod.POST, Api.login);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<String> register({
    @required String name,
    @required String email,
    @required String phoneNumber,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'token';
  }
}
