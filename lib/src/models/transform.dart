part of 'models.dart';

class DateTimeTransform implements Transformable<DateTime, String> {
  DateUnit unit;
  DateTimeTransform({this.unit = DateUnit.seconds});

  @override
  DateTime fromJson(value) {
    try {
      if (value == null) return null;
      if (value is String) return DateTime.parse(value);
      if (value is int) value = value.toDouble();
      if (value < 0) return null;

      return DateTime.fromMillisecondsSinceEpoch(unit.addScale(value).toInt());
    } catch (e) {
      return null;
    }
  }

  @override
  String toJson(DateTime value) {
    if (value == null) return null;

    return value.toIso8601String();
  }
}

class MultiSizeImageTransform implements Transformable<MultiSizeImage, String> {
  MultiSizeImageTransform();

  @override
  MultiSizeImage fromJson(value) {
    if (value is String) return MultiSizeImage(value);

    return null;
  }

  @override
  String toJson(MultiSizeImage value) {
    if (value == null) return null;

    return value.hugeThumb;
  }
}

class FriendTypeTransform implements Transformable<FriendType, String> {
  FriendTypeTransform();

  @override
  FriendType fromJson(value) {
    if (value is String) {
      for (final e in FriendType.values) {
        if (value == enumToString(e)) {
          return e;
        }
      }
    }

    return null;
  }

  @override
  String toJson(FriendType value) {
    if (value == null) return null;

    return enumToString(value);
  }
}
