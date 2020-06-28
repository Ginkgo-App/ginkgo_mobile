part of '../screens.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: FlareActor(
                Assets.flares.comingSoon,
                alignment: Alignment.center,
                sizeFromArtboard: true,
                fit: BoxFit.fitWidth,
                animation: "coding",
              ),
            ),
            Text(
              'Coming Soon!',
              style: context.textTheme.headline4.copyWith(
                  color: DesignColor.darkestRed, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
