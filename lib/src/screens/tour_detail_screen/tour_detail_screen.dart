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
