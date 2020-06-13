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
  static const tourInfoDetail = '/tour-info-detail';
  static const friendListScreen = '/friend-list-screen';
  static const createTour = '/create-tour';
  static const createTourInfo = '/create-tour-info';
  static const manageTour = '/manage-tour';
  static const placeDetail = '/place-detail';
  static const chooseTourInfo = '/choose-tour-info';
}

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
      return _generateMaterialRoute(UserScreen(
        args: settings.arguments,
      ));
    case Routes.email:
      return _generateMaterialRoute(EmailScreen());
    case Routes.profileTourList:
      return _generateMaterialRoute(TourListScreen());
    case Routes.tourDetail:
      return _generateMaterialRoute(TourDetailScreen());
    case Routes.tourInfoDetail:
      return _generateMaterialRoute(TourInfoDetailScreen(
        args: settings.arguments,
      ));
    case Routes.friendListScreen:
      return _generateMaterialRoute(FriendListScreen());
    case Routes.createTour:
      return _generateMaterialRoute(CreateTourScreen());
    case Routes.createTourInfo:
      return _generateMaterialRoute(CreateTourScreen());
    case Routes.manageTour:
      return _generateMaterialRoute(ManageTourScreen());
    case Routes.placeDetail:
      return _generateMaterialRoute(PlaceDetailScreen());
    case Routes.chooseTourInfo:
      return _generateMaterialRoute(ChooseTourInfoScreen());
    default:
      return _generateMaterialRoute(SplashScreen());
  }
};

MaterialPageRoute _generateMaterialRoute(Widget screen) {
  return MaterialPageRoute(builder: (BuildContext context) => screen);
}
