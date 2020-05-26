part of '../screens.dart';

class TourDetailScreenArgs {
  final SimpleTour simpleTour;

  TourDetailScreenArgs(this.simpleTour);
}

class TourDetailScreen extends StatefulWidget {
  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
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
            const SizedBox(height: 10),
            buildMembers(),
            TimelineWidget(
              timelines: List.generate(11, (_) => FakeData.timeline),
            ),
          ],
        ),
      ),
    );
  }

  buildMembers() {
    return BorderContainer(
      margin: EdgeInsets.symmetric(horizontal: 10),
      title: 'Những người tham gia',
      childPadding: EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: SpacingRow(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            isSpacingHeadTale: true,
            children: [
              ...[
                FakeData.simpleUser3,
                FakeData.simpleUser,
                FakeData.simpleUser2,
                FakeData.simpleUser4,
              ].map((e) => CircleUser(user: e)).toList(),
              ViewMoreButton(
                onPressed: () {},
                width: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
