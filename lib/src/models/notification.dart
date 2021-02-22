part of 'models.dart';

class NotificationInfo with Mappable {
  int id;
  String title;
  String message;
  String senderName;
  String type;
  DateTime readAt;
  DateTime sendAt;
  String payload;

  NotificationInfo(
      {this.id,
      this.title,
      this.message,
      this.senderName,
      this.type,
      this.readAt,
      this.sendAt,
      this.payload});

  // factory Notification.fromJson(Map<String, dynamic> json) {
  //   return Notification(
  //     id: json['id'],
  //     message: json['message'],
  //   );
  // }

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Title', title, (v) => title = v);
    map('Message', message, (v) => message = v);
    map('SenderName', senderName, (v) => senderName = v);
    map('Type', type, (v) => type = v);
    map('ReadAt', readAt, (v) => readAt = v, DateTimeTransform());
    map('SendAt', sendAt, (v) => sendAt = v, DateTimeTransform());
    map('Payload', payload, (v) => payload = v);
  }
}
