import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toDifferentDayNight(DateTime other) {
    final start = this.compareTo(other) > 0 ? other : this;
    final end = this.compareTo(other) > 0 ? this : other;

    int dayCount = end.difference(start).inDays;
    int nightCount = dayCount;

    if (start.hour < 12) dayCount++;
    if (end.hour >= 12) nightCount++;

    return '$dayCount ngày $nightCount đêm';
  }

  String toVietnameseFormat() => DateFormat('dd/MM/yyyy').format(this);
}
