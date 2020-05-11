library providers;

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/authResponse.dart';
import 'package:ginkgo_mobile/src/models/user.dart';

import 'appClient.dart';

part 'authProvider.dart';
part 'userProvider.dart';

class Api {
  static final login = AppConfig.instance.apiUrl + '/users/authenticate';
  static final socialLogin =
      AppConfig.instance.apiUrl + '/users/social-provider';
  static final register = AppConfig.instance.apiUrl + '/users/register';
  static final me = AppConfig.instance.apiUrl + '/users/me';
}
