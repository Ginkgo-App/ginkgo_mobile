import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

import 'message.dart';

class Conversation with Mappable {
  int _id;
  MultiSizeImage _image;
  String _name;
  Message _newestMessage;
  int _unreadMessages;

  int get id => _id;
  MultiSizeImage get image => _image;
  String get name => _name;
  Message get newestMessage => _newestMessage;
  int get unreadMessageCount => _unreadMessages;

  @override
  void mapping(Mapper map) {
    map('Id', _id, (v) => _id = v);
    map('Avatar', _image, (v) => _image = MultiSizeImage(v));
    map('Name', _name, (v) => _name = v);
    map<Message>('LastMessage', _newestMessage, (v) => _newestMessage = v);
    map('UnreadMessageCount', _unreadMessages, (v) => _unreadMessages = 0);
  }
}
