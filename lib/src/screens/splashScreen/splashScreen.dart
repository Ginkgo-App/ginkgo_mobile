part of screens;

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.home,
          size: 30,
          color: context.colorScheme.primary,
        ),
      ),
    );
  }
}
