import 'dart:math';

class ConvertLargeNumber {
  static String from(int number) {
    if (number == null || number == 0) return '0';
    int i = (log(number) / log(1000)).truncate();
    return (number % pow(1000, i) != 0
            ? (number / pow(1000, i)).toStringAsFixed(1)
            : (number / pow(1000, i)).toStringAsFixed(0)) +
        ['', 'k', 'm', 'b'][i];
  }
}
