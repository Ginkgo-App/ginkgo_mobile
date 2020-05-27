part of 'models.dart';

class Gender {
  static const male = const KeyValue(key: 'male', value: 'Nam');
  static const female = const KeyValue(key: 'female', value: 'Nữ');
  static const other = const KeyValue(key: 'other', value: 'Khác');

  static List<KeyValue> getList() => [male, female, other];

  static KeyValue fromKey(String key) =>
      getList().firstWhere((e) => e.key == key, orElse: () => null) ??
      fromNumber(int.tryParse(key) ?? 3);

  static KeyValue fromNumber(int number) {
    switch (number) {
      case 0:
        return male;
      case 1:
        return female;
      default:
        return other;
    }
  }
}

enum FriendType { none, accepted, requesting, waiting }

class User with Mappable {
  int id;
  String email;
  String phoneNumber;
  String fullName;
  MultiSizeImage avatar = MultiSizeImage('');
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
  FriendType friendType;

  String get displayName => fullName ?? email;
  String get displayGender => Gender.fromKey(gender).value;

  User({
    this.email = '',
    this.phoneNumber = '',
    this.fullName = '',
    this.avatar,
    this.slogan = '',
    this.bio = '',
    this.job = '',
    this.birthday,
    this.gender = '',
    this.address = '',
    this.tourCount = 0,
    this.friendType,
    friends,
  }) : this.friends = friends ?? Set.identity();

  SimpleUser toSimpleUser() => SimpleUser(
      id: this.id,
      name: this.fullName,
      avatar: this.avatar,
      job: this.job,
      tourCount: this.tourCount,
      friendType: this.friendType);

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', fullName, (v) => fullName = v);
    map('Email', email, (v) => email = v);
    map('PhoneNumber', phoneNumber, (v) => phoneNumber = v);
    map('Address', address, (v) => address = v);
    map('Avatar', avatar, (v) => avatar = v, MultiSizeImageTransform());
    map('Slogan', slogan, (v) => slogan = v);
    map('Bio', bio, (v) => bio = v);
    map('Job', job, (v) => job = v);
    map('Gender', gender, (v) => gender = v.toString());
    map('Birthday', birthday, (v) => birthday = v, DateTimeTransform());
    map('Role', role, (v) => role = v);
    map('TourCount', tourCount, (v) => tourCount = v);
    map<List<SocialProvider>>(
        'SocialProviders', socialProviders, (v) => socialProviders = v);
    map('FrienType', friendType, (v) => friendType = v, FriendTypeTransform());
  }
}

class SimpleUser with Mappable {
  int id;
  String name;
  String email;
  MultiSizeImage avatar;
  String job;
  int tourCount;
  FriendType friendType;

  String get displayName => name ?? email;

  SimpleUser(
      {this.id,
      this.name,
      this.avatar,
      this.job,
      this.tourCount,
      this.friendType});

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Name', name, (v) => name = v);
    map('Email', email, (v) => email = v);
    map('Avatar', avatar, (v) => avatar = v, MultiSizeImageTransform());
    map('Job', job, (v) => job = v);
    map('TourCount', tourCount, (v) => tourCount = v);
    map('FrienType', friendType, (v) => friendType = v, FriendTypeTransform());
  }
}

class UserToPut with Mappable {
  String name;
  String password;
  String phoneNumber;
  File avatar;
  String slogan;
  String bio;
  String job;
  DateTime birthday;
  String gender;
  String address;

  UserToPut(
      {this.name,
      this.password,
      this.phoneNumber,
      this.avatar,
      this.slogan,
      this.bio,
      this.job,
      this.birthday,
      this.gender,
      this.address});

  @override
  void mapping(Mapper map) {
    map('Name', name, (v) => name = v);
    map('Password', password, (v) => password = v);
    map('PhoneNumber', phoneNumber, (v) => phoneNumber = v);
    map('Address', address, (v) => address = v);
    map('Slogan', slogan, (v) => slogan = v);
    map('Bio', bio, (v) => bio = v);
    map('Job', job, (v) => job = v);
    map('Gender', gender, (v) => gender = v);
    map('Birthday', birthday, (v) => birthday = v, DateTimeTransform());
  }
}
