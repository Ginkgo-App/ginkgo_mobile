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

  Future<Conversation> getConversationDetail(ConversationKey key) async {
    return await _client.connect<Conversation>(
        ApiMethod.GET,
        Api.chats +
            (key.conversationId != null
                ? '/tour/${key.conversationId}'
                : '/user/${key.targetUserId}'));
  }

  Future sendMessage(int id, String content) async {
    await _client.normalConnect(ApiMethod.POST, Api.chatsMessage, body: {
      'GroupId': id,
      'Content': content,
    });
  }

  Future<Pagination<Message>> getMessages(int id,
      {int page, int pageSize}) async {
    final response = await _client
        .normalConnect(ApiMethod.GET, Api.chats + '/$id/messages', query: {
      'page': (page ?? 1).toString(),
      'pageSize': (pageSize?.toString() ?? 20).toString(),
    });

    return Pagination<Message>(
        response.data['Pagination'], response.data['Data']);
  }
}
