library providers;

import 'dart:convert';

import 'package:base/base.dart';
import 'package:flutter/material.dart';

part 'authProvider.dart';

class Api {
  static final login = AppConfig.instance.apiUrl + '/users/authenticate';
  static final socialLogin = AppConfig.instance.apiUrl + '/users/social-provider';
  static final register = AppConfig.instance.apiUrl + '/users/register';
}
