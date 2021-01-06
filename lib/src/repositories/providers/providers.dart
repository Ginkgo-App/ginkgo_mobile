library providers;

import 'dart:io';

import 'package:base/base.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

import 'apiClient.dart';

part 'authProvider.dart';
part 'placeProvider.dart';
part 'systemProvider.dart';
part 'tourInfoProvider.dart';
part 'tourProvider.dart';
part 'userProvider.dart';
part 'post_provider.dart';
part 'chat_provider.dart';

class Api {
  static final image = 'https://api.imgur.com/3/image';
  static final login = AppConfig.instance.apiUrl + '/users/authenticate';
  static final socialLogin =
      AppConfig.instance.apiUrl + '/users/social-provider';
  static final register = AppConfig.instance.apiUrl + '/users/register';
  static final me = AppConfig.instance.apiUrl + '/users/me';
  static final meFriends = AppConfig.instance.apiUrl + '/users/me/friends';
  static final topUser = AppConfig.instance.apiUrl + '/tours/top-users';
  static final meTours = AppConfig.instance.apiUrl + '/users/me/tours';
  static final mePosts = AppConfig.instance.apiUrl + '/users/me/posts';
  static final chats = AppConfig.instance.apiUrl + '/chats';

  static chatDetail(int id) => AppConfig.instance.apiUrl + '/chats/group/$id';
  static String places(int placeId) =>
      AppConfig.instance.apiUrl + '/places/${placeId ?? ''}';
  static String posts(int postId) =>
      AppConfig.instance.apiUrl + '/posts/${postId ?? ''}';
  static String tourInfos(int tourInfoId) =>
      AppConfig.instance.apiUrl + '/tour-infos/${tourInfoId ?? ''}';
  static String tourInfosTourList(int tourInfoId) =>
      AppConfig.instance.apiUrl + '/tour-infos/$tourInfoId/tours';
  static String tourInTourInfo(int tourInfoId) =>
      AppConfig.instance.apiUrl + '/tour-infos/$tourInfoId' + '/tours';
  static String tour(int tourId) =>
      AppConfig.instance.apiUrl + '/tours/${tourId ?? ''}';
  static String addFriend(int userId) =>
      AppConfig.instance.apiUrl + '/users/me/friends/$userId';
  static String deleteFriend(int userId) =>
      AppConfig.instance.apiUrl + '/users/me/friends/$userId';
  static String acceptFriend(int userId) =>
      AppConfig.instance.apiUrl + '/users/me/accept-friend/$userId';
  static String userTours(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId/tours';
  static String userPosts(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId/posts';
  static String userFriends(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId/friends';
  static String userInfo(int userId) =>
      AppConfig.instance.apiUrl + '/users/$userId';
}
