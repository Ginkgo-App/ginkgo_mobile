import 'package:flutter/material.dart';

class HomeProvider extends InheritedWidget {
  final BuildContext context;
  final bool scrollProfileToActivityBox;

  HomeProvider(this.context,
      {this.scrollProfileToActivityBox = false, Widget child})
      : super(child: child);

  static HomeProvider of(BuildContext myContext) =>
      myContext.dependOnInheritedWidgetOfExactType(aspect: HomeProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
