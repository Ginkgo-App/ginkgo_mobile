part of '../screens.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(AppConfig.instance.appName),
            SizedBox(height: 20,),
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
