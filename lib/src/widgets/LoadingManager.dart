import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class LoadingManager {
  LoadingManager._();
  static LoadingManager _instance = LoadingManager._();
  factory LoadingManager() => _instance;

  int showCount = 0;

  show(BuildContext context) {
    if (showCount == 0) {
      debugPrint('Show Loading.................');
      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => LoadingIndicator(),
        );
        showCount++;
      } catch (e) {
        debugPrint(e);
      }
    } else {
      showCount++;
    }
  }

  hide(BuildContext context) {
    if (showCount == 1) {
      debugPrint('Hide Loading.................');
      Navigators.appNavigator.currentState.pop();
    } else if (showCount <= 1) {
      return;
    }
    showCount--;
  }
}
