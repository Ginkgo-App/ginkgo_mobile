import 'package:ginkgo_mobile/src/models/socialProvider.dart';
import 'package:object_mapper/object_mapper.dart';

enum Gender { male, female, other }

class User with Mappable {
  int id;
  String email;
  String phoneNumber;
  String fullName;
  String avatar;
  String slogan;
  String bio;
  String job;
  DateTime birthday;
  String gender;
  String address;
  String role;
  List<SocialProvider> socialProviders;
  Set<User> friends;

  String get displayName => fullName ?? email;

  User({
    this.email = '',
    this.phoneNumber = '',
    this.fullName = '',
    this.avatar = '',
    this.slogan = '',
    this.bio = '',
    this.job = '',
    this.birthday,
    this.gender = '',
    this.address = '',
    friends,
  }) : this.friends = friends ?? Set.identity();

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', fullName, (v) => fullName = v);
    map('Email', email, (v) => email = v);
    map('PhoneNumber', phoneNumber, (v) => phoneNumber = v);
    map('Address', address, (v) => address = v);
    map('Avatar', avatar, (v) => avatar = v);
    map('Slogan', slogan, (v) => slogan = v);
    map('Bio', bio, (v) => bio = v,);
    map('Gender', gender, (v) => gender = v.toString());
    map('Birthday', birthday, (v) => birthday = v, DateTransform());
    map('Role', role, (v) => role = v);
    map<List<SocialProvider>>('SocialProviders', socialProviders, (v) => socialProviders = v);
  }
}
