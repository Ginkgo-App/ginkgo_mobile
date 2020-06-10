part of 'models.dart';

class AuthResponse with Mappable {
  int id;
  String token;

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Token', token, (v) => token = v);
  }
}
