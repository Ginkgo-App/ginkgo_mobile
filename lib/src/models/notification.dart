part of 'models.dart';

class Notification with Mappable {
  int id;
  String message;
  int type;
  DateTime readAt;
  DateTime createdAt;
  String payload;

  Notification(
      {this.id,
      this.message,
      this.type,
      this.readAt,
      this.createdAt,
      this.payload});

  // factory Notification.fromJson(Map<String, dynamic> json) {
  //   return Notification(
  //     id: json['id'],
  //     message: json['message'],
  //   );
  // }

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('message', message, (v) => message = v);
    map('type', type, (v) => type = v);
    map('readAt', readAt, (v) => readAt = v, DateTransform());
    map('createdAt', createdAt, (v) => createdAt = v, DateTransform());
    map('payload', payload, (v) => payload = v);
  }
}
