import 'package:object_mapper/object_mapper.dart';

enum SocialType { facebook, google }

class SocialProvider with Mappable {
  String id;
  String name;
  String email;
  String avatar;
  String type;

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('Email', email, (v) => email = v);
    map('Avatar', avatar, (v) => avatar = v);
    map('Type', type, (v) => type = v);
  }
}
