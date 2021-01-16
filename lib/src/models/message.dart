import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

class Message with Mappable {
  String _message;
  DateTime _createdAt;
  SimpleUser _sender;
  List<MultiSizeImage> _images;

  String get message => _message;
  DateTime get createdAt => _createdAt;
  SimpleUser get sender => _sender;
  List<MultiSizeImage> get images => _images;

  Message(
      {String message,
      DateTime createdAt,
      SimpleUser sender,
      List<MultiSizeImage> images})
      : _message = message,
        _createdAt = createdAt,
        _sender = sender,
        _images = images;

  @override
  void mapping(Mapper map) {
    map('Content', _message, (v) => _message = v);
    map('CreateAt', _createdAt, (v) => _createdAt = v, DateTimeTransform());
    map<SimpleUser>('Sender', _sender, (v) => _sender = v);
    map<SimpleUser>('Sender', _sender, (v) => _sender = v);
    map<MultiSizeImage>(
        'Images', images, (v) => _images = v, MultiSizeImageTransform());
  }
}
