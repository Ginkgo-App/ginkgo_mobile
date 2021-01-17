import 'dart:io';

import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

import 'conversation.dart';
import 'conversation.dart';

class Message with Mappable {
  String _message;
  DateTime _createdAt;
  SimpleUser _sender;
  List<MultiSizeImage> _images;
  List<File> imageFiles;

  String get message => _message;
  DateTime get createdAt => _createdAt;
  SimpleUser get sender => _sender;
  List<MultiSizeImage> get images => _images;

  Message({
    String message,
    DateTime createdAt,
    SimpleUser sender,
    List<MultiSizeImage> images,
  })  : _message = message,
        _createdAt = createdAt,
        _sender = sender,
        _images = images;

  @override
  void mapping(Mapper map) {
    map('Content', _message, (v) => _message = v);
    map('CreateAt', _createdAt, (v) => _createdAt = v, DateTimeTransform());
    map<SimpleUser>('Sender', _sender, (v) => _sender = v);
    map<MultiSizeImage>(
        'Images', images, (v) => _images = v, MultiSizeImageTransform());
  }
}

class MessageFromStream extends Message {
  Conversation _conversation;
  Conversation get conversation => _conversation;

  MessageFromStream({
    Conversation conversation,
    String message,
    DateTime createdAt,
    SimpleUser sender,
    List<MultiSizeImage> images,
  })  : _conversation = conversation,
        super(message: message, createdAt: createdAt, sender: sender);

  @override
  void mapping(Mapper map) {
    super.mapping(map);
    map<Conversation>('Group', _conversation,
        (v) => _conversation = (v as Conversation)..newestMessage = this);
  }
}
