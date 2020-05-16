import 'package:ginkgo_mobile/src/models/models.dart';
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
  int tourCount;

  String get displayName => fullName ?? email;
  String get displayGender => gender;

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
    this.tourCount = 0,
    friends,
  }) : this.friends = friends ?? Set.identity();

  SimpleUser toSimpleUser() => SimpleUser(
    id: this.id,
    name: this.fullName,
    avatar: this.avatar,
    job: this.job,
    tourCount: this.tourCount
  );

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', fullName, (v) => fullName = v);
    map('Email', email, (v) => email = v);
    map('PhoneNumber', phoneNumber, (v) => phoneNumber = v);
    map('Address', address, (v) => address = v);
    map('Avatar', avatar, (v) => avatar = v);
    map('Slogan', slogan, (v) => slogan = v);
    map(
      'Bio',
      bio,
      (v) => bio = v,
    );
    map('Gender', gender, (v) => gender = v.toString());
    map('Birthday', birthday, (v) => birthday = v, DateTransform());
    map('Role', role, (v) => role = v);
    map('TourCount', tourCount, (v) => tourCount = v);
    map<List<SocialProvider>>(
        'SocialProviders', socialProviders, (v) => socialProviders = v);
  }
}

class SimpleUser with Mappable {
   int id;
   String name;
   String email;
   String avatar;
   String job;
   int tourCount;

  String get displayName => name ?? email;

  SimpleUser({this.id, this.name, this.avatar, this.job, this.tourCount});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('Email', email, (v) => email = v);
    map('Avatar', avatar, (v) => avatar = v);
    map('Job', job, (v) => job = v);
    map('TourCount', tourCount, (v) => tourCount = v );
  }
}
