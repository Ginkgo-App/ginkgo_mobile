part of '../screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InfoBox(),
            Text(AppConfig.instance.appName),
            SizedBox(height: 20,),
            PrimaryButton(
              title: 'Profile',
              onPressed: () {
                Navigator.pushNamed(context, Routes.profile);
              },
            ),
            PrimaryButton(
              title: Strings.button.logout,
              onPressed: () {
                AuthBloc().add(AuthEventLogout());
              },
            )
          ],
        ),
      ),
    );
  }
}
