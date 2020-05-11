part of providers;

class AuthProvider {
  final _client = ApiClient();

  Future<AuthResponse> login(String email, String password) async {
    final response =
        await _client.normalConnect(ApiMethod.POST, Api.login, body: {
      'Email': email,
      'Password': password,
    });
    return Mapper.fromJson(response.data['Data'][0])
        .toObject<AuthResponse>();
  }

  Future<AuthResponse> loginFacebook(String accessToken, [String email]) async {
    final body = {
      'Type': 'facebook',
      'AccessToken': accessToken,
    };

    // Code to test social does not provide email.
    // if (email != null) {
    //   body.addAll({'Email': email});
    // } else {
    //   throw ServerError(errorCode: 9, message: 'null');
    // }

    final response = await _client
        .normalConnect(ApiMethod.POST, Api.socialLogin, body: body);
    return Mapper.fromJson(response.data['Data'][0])
        .toObject<AuthResponse>();
  }

  Future logout() async {
    // _client.normalConnect(ApiMethod.POST, Api.login);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<AuthResponse> register({
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
    return Mapper.fromJson(response.data['Data'][0])
        .toObject<AuthResponse>();
  }
}
