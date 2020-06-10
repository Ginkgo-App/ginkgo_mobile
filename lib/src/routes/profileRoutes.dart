part of '../app.dart';

class ProfileRoutes {
  static const profile = '/';
  static const listTour = '/list-tour';
  static const manageTour = '/manage-tour';
}

RouteFactory onGenerateProfileRoute = (RouteSettings settings) {
  switch (settings.name) {
    case ProfileRoutes.listTour:
      return _generateMaterialRoute(TourListScreen());
    case ProfileRoutes.manageTour:
      return _generateMaterialRoute(ManageTourScreen());
    default:
      return _generateMaterialRoute(ProfileScreen());
  }
};
