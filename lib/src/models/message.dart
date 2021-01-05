import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

import 'conversation.dart';

class Message with Mappable {
  Conversation _conversation;
  String _message;
  DateTime _createdAt;
  DateTime _updatedAt;
  SimpleUser _sender;

  Conversation get conversation => _conversation;
  String get message => _message;
  DateTime get createdAt => _createdAt;
  DateTime get updatedAt => _updatedAt;
  SimpleUser get sender => _sender;

  Message({
    String id,
    Conversation conversation,
    String message,
    DateTime createdAt,
    DateTime updatedAt,
    SimpleUser sender,
  })  : _conversation = conversation,
        _message = message,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _sender = sender;

  @override
  void mapping(Mapper map) {
    map<Conversation>('conversation', _conversation, (v) => _conversation = v);
    map('message', _message, (v) => _message = v);
    map('createdAt', _createdAt, (v) => _createdAt = v, DateTransform());
    map('updatedAt', _updatedAt, (v) => _updatedAt = v, DateTransform());
    map<SimpleUser>('sender', _sender, (v) => _sender = v);
  }
}
