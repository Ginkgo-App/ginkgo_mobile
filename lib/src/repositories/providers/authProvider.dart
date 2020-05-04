part of providers;

class AuthProvider {
  final _client = ApiClient();

  Future<String> login(String email, String password) async {
    final response =
        await _client.normalConnect(ApiMethod.POST, Api.login, body: {
      'Email': email,
      'Password': password,
    });
    return jsonDecode(response.data)['Data'][0];
  }

  Future<String> loginFacebook(String accessToken, [String email]) async {
    final body = {
      'Type': 'facebook',
      'AccessToken': accessToken,
    };

    if (email != null) {
      body.addAll({'Email': email});
    } else {
      throw ServerError(errorCode: 9, message: 'null');
    }

    final response = await _client
        .normalConnect(ApiMethod.POST, Api.socialLogin, body: body);
    return jsonDecode(response.data)['Data'][0];
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
    final response =
        await _client.normalConnect(ApiMethod.POST, Api.register, body: {
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
    });
    return jsonDecode(response.data)['Data'][0];
  }
}
