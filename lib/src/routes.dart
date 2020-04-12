part of 'app.dart';

class Routes {
  static const splash = '/';
}

final Map<String, Widget Function(BuildContext)> _routeBuilder = {};

RouteFactory _onGenerateRoute = (RouteSettings settings) {
  switch (settings.name) {
    default:
      return _generateMaterialRoute(SplashScreen());
  }
};

MaterialPageRoute _generateMaterialRoute(Widget screen) {
  return MaterialPageRoute(builder: (BuildContext context) => screen);
}
