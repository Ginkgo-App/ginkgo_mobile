part of screens;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 20),
            LoadingDotIndicator(),
          ],
        ),
      ),
    );
  }
}
