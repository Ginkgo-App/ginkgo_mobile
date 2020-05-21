part of providers;

class SystemProvider {
  final _client = ApiClient();

  Future<String> uploadImage(File image) async {
    final response = await _client.normalConnect(
      ApiMethod.POST,
      Api.image,
      data: FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path),
        'album': 'dPkd7RpwCPaPMB9',
      }),
      headers: {
        'Authorization': 'Client-ID eee6fe9fcde03e2'
      },
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
