import 'package:flutter/material.dart';

class HomeProvider extends InheritedWidget {
  final BuildContext context;

  HomeProvider(this.context, {Widget child}) : super(child: child);

  static HomeProvider of(context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: HomeProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
