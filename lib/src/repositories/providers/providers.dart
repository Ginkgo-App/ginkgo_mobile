library providers;

import 'package:base/base.dart';
import 'package:flutter/material.dart';

part 'authProvider.dart';

class Api {
  static final login = AppConfig.instance.apiUrl + '/login';
  static final loginFacebook = AppConfig.instance.apiUrl + '/login-facebook';
  static final register = AppConfig.instance.apiUrl + '/register';
}
