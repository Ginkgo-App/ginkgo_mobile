library providers;

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/authResponse.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:object_mapper/object_mapper.dart';

import 'appClient.dart';

part 'authProvider.dart';
part 'userProvider.dart';

class Api {
  static final login = AppConfig.instance.apiUrl + '/users/authenticate';
  static final socialLogin =
      AppConfig.instance.apiUrl + '/users/social-provider';
  static final register = AppConfig.instance.apiUrl + '/users/register';
  static final me = AppConfig.instance.apiUrl + '/users/me';
  static final meFriends = AppConfig.instance.apiUrl + '/users/me/friends';
  static String userFriends(int userId) =>
      AppConfig.instance.apiUrl + '/users/users/$userId/friends';
  static final meTours = AppConfig.instance.apiUrl + '/users/me/tours';
}
