class ConversationKey {
  final int conversationId;
  final int targetUserId;

  ConversationKey({this.conversationId, this.targetUserId})
      : assert(conversationId != null || targetUserId != null);

  @override
  String toString() => conversationId != null
      ? '{conversationId: $conversationId}'
      : '{userId: $targetUserId}';
}
