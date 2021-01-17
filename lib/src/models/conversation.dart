import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

import 'message.dart';

class Conversation with Mappable {
  int _id;
  MultiSizeImage _image;
  String _name;
  Message newestMessage;
  int _unreadMessages;

  int get id => _id;
  MultiSizeImage get image => _image;
  String get name => _name;
  int get unreadMessageCount => _unreadMessages;

  @override
  void mapping(Mapper map) {
    map('Id', _id, (v) => _id = v);
    map('Avatar', _image, (v) => _image = MultiSizeImage(v));
    map('Name', _name, (v) => _name = v);
    map<Message>('LastMessage', newestMessage, (v) => newestMessage = v);
    map('UnreadCount', _unreadMessages, (v) => _unreadMessages = v);
  }
}
