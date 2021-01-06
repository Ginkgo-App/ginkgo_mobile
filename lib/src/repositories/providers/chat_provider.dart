part of providers;

class ChatProvider {
  final _client = ApiClient();

  Future<Conversation> getDetail(int id) async {
    final result =
        await _client.connect<Conversation>(ApiMethod.GET, Api.chatDetail(id));

    return result;
  }

  Future<Pagination<Conversation>> getList({int page, int pageSize}) async {
    final response =
        await _client.normalConnect(ApiMethod.GET, Api.chats, query: {
      'page': (page ?? 1).toString(),
      'pageSize': (pageSize?.toString() ?? 0).toString(),
    });

    return Pagination<Conversation>(
        response.data['Pagination'], response.data['Data']);
  }
}
