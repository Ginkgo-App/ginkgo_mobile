part of base;

String enumToString(Object object) {
  return object.toString().split('.').last;
}
