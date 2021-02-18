part of base;

extension StringExt on String {
  bool get isExistAndNotEmpty => this != null && this.isNotEmpty;

  String removeCode() => this.replaceAll('\\n', '\n').replaceAll('\\t', '\t');

  bool get isVNPhoneNumber =>
      RegExp(r"(09|03|01[2|6|8|9])+([0-9]{8})\b").hasMatch(this);

  DateTime toVietNameseDate() {
    try {
      return DateFormat('dd/MM/yyyy').parse(this);
    } catch (e) {
      debugPrint('Can\'t parse DateTime: $e');
      return null;
    }
  }
}
