part of providers;

class SystemProvider {
  final _client = ApiClient();

  Future<String> uploadImage(File image) async {
    final response = await _client.normalConnect(
      ApiMethod.POST,
      Api.login,
      data: FormData.fromMap({
        'image': MultipartFile.fromFile(image.path),
        'album': 'dPkd7RpwCPaPMB9',
      }),
      handleError: false,
    );

    final decoded = response.data;

    if (decoded['success'] != null && decoded['success']) {
      return decoded['data']['link'];
    } else {
      throw decoded['data']['error'] ?? '';
    }
  }
}
