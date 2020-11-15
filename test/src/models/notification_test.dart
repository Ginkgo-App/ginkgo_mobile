import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:object_mapper/object_mapper.dart';

final Map<String, dynamic> json = {
  "id": 1,
  "message": "Abcxyz",
  "type": 1,
  "readAt": "2020-11-07T16:34:53.931Z",
  "createdAt": "2020-11-07T16:34:53.931Z",
  "payload": "123"
};

void main() {
  setUp(() {
    objectMapping();
  });

  test("Test Simple User model mapping", () {
    var mapper = Mapper.fromJson(json);
    final notification = mapper.toObject<Notification>();

    expect(notification.id, json['id']);
    expect(notification.message, json['message']);
    expect(notification.payload, json['payload']);
    expect(notification.type, json['type']);
    expect(notification.readAt.toIso8601String(), json['readAt']);
    expect(notification.createdAt.toIso8601String(), json['createdAt']);
  });

  test('Test to json', () {
    final notification = Mapper.fromJson(json).toObject<Notification>();

    final notificationJson = notification.toJson();

    expect(notificationJson, json);
  });
}
