part of '../app.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/profile';
  static const user = '/user';
  static const email = '/email';
  static const profileTourList = '/profile-tour-list';
  static const tourDetail = '/tour-detail';
  static const friendListScreen = '/friend-list-screen';
}

final Map<String, Widget Function(BuildContext)> _routeBuilder = {
  Routes.login: (context) => LoginScreen(),
  Routes.register: (context) => RegisterScreen(),
  Routes.home: (context) => HomeScreen(),
  Routes.profile: (context) => ProfileScreen(),
  Routes.user: (context) => UserScreen(),
  Routes.email: (context) => EmailScreen(),
  Routes.profileTourList: (context) => ProfileListTourScreen(),
  Routes.tourDetail: (context) => TourDetailScreen(),
  Routes.friendListScreen: (context) => FriendListScreen(),
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
    case Routes.user:
      return _generateMaterialRoute(UserScreen());
    case Routes.email:
      return _generateMaterialRoute(EmailScreen());
    case Routes.profileTourList:
      return _generateMaterialRoute(ProfileListTourScreen());
    case Routes.tourDetail:
      return _generateMaterialRoute(TourDetailScreen());
    case Routes.friendListScreen:
      return _generateMaterialRoute(FriendListScreen());
    default:
      return _generateMaterialRoute(SplashScreen());
  }
};

MaterialPageRoute _generateMaterialRoute(Widget screen) {
  return MaterialPageRoute(builder: (BuildContext context) => screen);
}
