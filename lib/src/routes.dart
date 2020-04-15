part of 'app.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
}

final Map<String, Widget Function(BuildContext)> _routeBuilder = {
  Routes.login: (context) => LoginScreen()
};

RouteFactory _onGenerateRoute = (RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return _generateMaterialRoute(LoginScreen());
    default:
      return _generateMaterialRoute(SplashScreen());
  }
};

MaterialPageRoute _generateMaterialRoute(Widget screen) {
  return MaterialPageRoute(builder: (BuildContext context) => screen);
}
