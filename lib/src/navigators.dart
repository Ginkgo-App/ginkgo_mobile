import 'package:base/base.dart';
import 'package:flutter/material.dart';

class Navigators {
  static final GlobalKey<NavigatorState> appNavigator = AppConfig.navigatorKey;
  static final GlobalKey<NavigatorState> homeNavigator = GlobalKey();
  static final GlobalKey<NavigatorState> profileNavigator = GlobalKey();
}
