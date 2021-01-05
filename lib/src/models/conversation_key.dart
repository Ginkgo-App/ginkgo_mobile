import 'package:base/base.dart';

class ConversationKey {
  final String conversationId;
  final String targetUserId;

  ConversationKey({this.conversationId, this.targetUserId})
      : assert(conversationId != null || targetUserId != null);

  @override
  String toString() => conversationId.isExistAndNotEmpty
      ? '{conversationId: $conversationId}'
      : '{userId: $targetUserId}';
}
