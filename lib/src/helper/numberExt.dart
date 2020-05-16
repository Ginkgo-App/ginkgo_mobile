import 'package:intl/intl.dart';

extension IntExt on int {
  String toMoney() =>
      NumberFormat.currency(locale: 'vi_VI', symbol: 'VNĐ').format(this);
  String toShortMoney() =>
      NumberFormat.compactCurrency(locale: 'vi_VI', symbol: 'VNĐ').format(this);
}

extension DoubleExt on double {
  String toMoney() => this.round().toMoney();
  String toShortMoney() => this.round().toShortMoney();
}
