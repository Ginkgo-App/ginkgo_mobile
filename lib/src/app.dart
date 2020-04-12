library app;

import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/screens/screens.dart';

part 'routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ginkgo Mobile',
      initialRoute: Routes.splash,
      routes: _routeBuilder,
      onGenerateRoute: _onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
