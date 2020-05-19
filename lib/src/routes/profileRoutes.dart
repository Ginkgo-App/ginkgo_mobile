part of '../app.dart';

class ProfileRoutes {
  static const profile = '/';
  static const listTour = '/list-tour';
}

RouteFactory onGenerateProfileRoute = (RouteSettings settings) {
  switch (settings.name) {
    case ProfileRoutes.listTour:
      return _generateMaterialRoute(ProfileListTourScreen());
    default:
      return _generateMaterialRoute(ProfileScreen());
  }
};
