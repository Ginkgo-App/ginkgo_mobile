import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

import 'message.dart';

class Conversation with Mappable {
  MultiSizeImage _image;
  String _name;
  Message _newestMessage;
  bool _isOnline;
  DateTime _lastOnline;
  int _unreadMessages;

  MultiSizeImage get image => _image;
  String get name => _name;
  Message get newestMessage => _newestMessage;
  bool get isOnline => _isOnline;
  DateTime get lastOnline => _lastOnline;
  int get unreadMessageCount => _unreadMessages;

  @override
  void mapping(Mapper map) {
    map<MultiSizeImage>('data.image', _image, (v) => _image = v);
    map('data.name', _name, (v) => _name = v);
    map<Message>(
        'data.newestMessage', _newestMessage, (v) => _newestMessage = v);
    map('data.isOnline', _isOnline, (v) => _isOnline = v);
    map('data.lastOnline', _lastOnline, (v) => _lastOnline = v,
        DateTransform());
    map('personalData.unreadMessageCount', _unreadMessages,
        (v) => _unreadMessages = v);
  }
}
