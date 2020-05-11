import 'package:object_mapper/object_mapper.dart';

class AuthResponse with Mappable {
  int id;
  String token;

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('token', token, (v) => token = v);
  }
}
