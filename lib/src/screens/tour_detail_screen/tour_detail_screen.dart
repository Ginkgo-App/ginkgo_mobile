part of '../screens.dart';

class TourDetailScreenArgs {
  final SimpleTour simpleTour;

  TourDetailScreenArgs(this.simpleTour);
}

class TourDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Chi tiết chuyến đi',
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: PrimaryButton(
          title: Strings.button.takePartInNow,
          width: double.maxFinite,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SliderWidget(images: FakeData.simpleTour.images),
            TimelineWidget(
              timelines: List.generate(11, (_) => FakeData.timeline),
            ),
          ],
        ),
      ),
    );
  }
}
