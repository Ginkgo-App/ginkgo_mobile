part of '../../screens.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Navigators.profileNavigator,
      onGenerateRoute: onGenerateProfileRoute,
    );
  }
}
