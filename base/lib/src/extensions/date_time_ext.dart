part of base;

extension DateTimeExt on DateTime {
  String toVietNamese() => DateFormat('dd/MM/yyyy').format(this);
}