library providers;

import 'dart:io';

import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

import 'appClient.dart';

part 'authProvider.dart';
part 'systemProvider.dart';
part 'userProvider.dart';

class Api {
  static final image = 'https://api.imgur.com/3/image';
  static final login = AppConfig.instance.apiUrl + '/users/authenticate';
  static final socialLogin =
      AppConfig.instance.apiUrl + '/users/social-provider';
  static final register = AppConfig.instance.apiUrl + '/users/register';
  static final me = AppConfig.instance.apiUrl + '/users/me';
  static final meFriends = AppConfig.instance.apiUrl + '/users/me/friends';
  static final meTours = AppConfig.instance.apiUrl + '/users/me/tours';

  static String addFriend(int userId) =>
      AppConfig.instance.apiUrl + '/users/me/friends/$userId';
  static String deleteFriend(int userId) =>
      AppConfig.instance.apiUrl + '/users/me/friends/$userId';
  static String acceptFriend(int userId) =>
      AppConfig.instance.apiUrl + '/users/me/accept-friend/$userId';
  static String userTours(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId/tours';
  static String userFriends(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId/friends';
  static String userInfo(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId';
}
