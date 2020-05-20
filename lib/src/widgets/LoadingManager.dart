import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class LoadingManager {
  LoadingManager._();
  static LoadingManager _instance = LoadingManager._();
  factory LoadingManager() => _instance;

  bool _isShowing = false;

  show(BuildContext context) {
    if (!_isShowing) {
      debugPrint('Show Loading.................');
      _isShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingIndicator(),
      );
    }
  }

  hide(BuildContext context) {
    if (_isShowing) {
      debugPrint('Hide Loading.................');
      _isShowing = false;
      Navigators.appNavigator.currentState.pop();
    }
  }
}
