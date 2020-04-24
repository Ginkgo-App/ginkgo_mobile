import 'package:flutter/cupertino.dart';

enum Gender { male, female, other }

class User {
  final String email;
  final String phoneNumber;
  final String fullName;
  final String avatar;
  final String slogan;
  final String bio;
  final String job;
  final DateTime birthday;
  final Gender gender;
  final String address;
  final Set<User> friends;

  User({
    @required this.email,
    this.phoneNumber,
    this.fullName,
    this.avatar,
    this.slogan,
    this.bio,
    this.job,
    this.birthday,
    this.gender,
    this.address,
    friends,
  }) : this.friends = friends ?? Set.identity();
}
