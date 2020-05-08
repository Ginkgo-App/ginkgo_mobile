part of 'app.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/profile';
  static const email = '/email';
}

final Map<String, Widget Function(BuildContext)> _routeBuilder = {
  Routes.login: (context) => LoginScreen(),
  Routes.register: (context) => RegisterScreen(),
  Routes.home: (context) => HomeScreen(),
  Routes.profile: (context) => ProfileScreen(),
  Routes.email: (context) => EmailScreen(),
};

RouteFactory _onGenerateRoute = (RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return _generateMaterialRoute(LoginScreen());
    case Routes.register:
      return _generateMaterialRoute(RegisterScreen());
    case Routes.home:
      return _generateMaterialRoute(HomeScreen());
    case Routes.profile:
      return _generateMaterialRoute(ProfileScreen());
    case Routes.email:
      return _generateMaterialRoute(EmailScreen());
    default:
      return _generateMaterialRoute(SplashScreen());
  }
};

MaterialPageRoute _generateMaterialRoute(Widget screen) {
  return MaterialPageRoute(builder: (BuildContext context) => screen);
}
