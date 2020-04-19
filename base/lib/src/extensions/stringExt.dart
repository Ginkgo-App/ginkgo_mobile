part of base;

extension StringExt on String {
  bool get isExistAndNotEmpty => this != null && this.isNotEmpty;

  String removeCode() => this.replaceAll('\\n', '\n').replaceAll('\\t', '\t');

  bool get isEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool get isVNPhoneNumber => RegExp(r"(09|01[2|6|8|9])+([0-9]{8})\b").hasMatch(this);
}
