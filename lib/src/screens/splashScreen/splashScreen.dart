part of screens;

class SplashScreen extends StatelessWidget {
  SplashScreen() {
    Future.delayed(Duration(seconds: 2)).then((_) =>
        AppConfig.navigatorKey.currentState.pushReplacementNamed(Routes.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            const SizedBox(height: 20),
            LoadingDotIndicator(),
          ],
        ),
      ),
    );
  }
}
