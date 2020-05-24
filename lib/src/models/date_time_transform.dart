import 'package:object_mapper/object_mapper.dart';

class DateTimeTransform implements Transformable<DateTime, String> {
  DateUnit unit;
  DateTimeTransform({this.unit = DateUnit.seconds});

  //
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
