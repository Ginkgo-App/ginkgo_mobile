part of '../../screens.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Navigators.profileNavigator,
      onGenerateRoute: onGenerateProfileRoute,
    );
  }
}
