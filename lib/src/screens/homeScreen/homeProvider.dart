import 'package:flutter/material.dart';

class HomeProvider extends InheritedWidget {
  final BuildContext context;

  HomeProvider(this.context, {Widget child}) : super(child: child);

  static HomeProvider of(BuildContext myContext) =>
      myContext.dependOnInheritedWidgetOfExactType(aspect: HomeProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}