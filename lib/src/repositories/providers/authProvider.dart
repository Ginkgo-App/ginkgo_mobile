part of providers;

class AuthProvider {
  final _client = ApiClient();

  Future<AuthResponse> login(String email, String password) async {
    // Dùng để hack login khi server sập, lưu ý token có thể hết hạn.
    // return AuthResponse()
    //   ..token =
    //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIyIiwidW5pcXVlX25hbWUiOiJnYXBoYWd1bjEyQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsIm5iZiI6MTU4OTkwMDc3OSwiZXhwIjoxNTkwNTA1NTc5LCJpYXQiOjE1ODk5MDA3Nzl9.74LL0gRgWB_-sQXWe9cUuLUgMA2PJTIuxquuxjYV__g';
    final result =
        await _client.connect<AuthResponse>(ApiMethod.POST, Api.login, body: {
      'Email': email,
      'Password': password,
    });
    return result;
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

    final result = await _client
        .connect<AuthResponse>(ApiMethod.POST, Api.socialLogin, body: body);
    return result;
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
    final result = await _client
        .connect<AuthResponse>(ApiMethod.POST, Api.register, body: {
      'Name': name,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Password': password,
    });
    return result;
  }
}
