part of '../screens.dart';

class CreateTourScreen extends StatefulWidget {
  final TourInfo tourInfo;

  const CreateTourScreen({Key key, this.tourInfo}) : super(key: key);

  @override
  _CreateTourScreenState createState() => _CreateTourScreenState();
}

class _CreateTourScreenState extends State<CreateTourScreen> {
  final PageController pageController = PageController();
  TourInfo tourInfo;

  @override
  Widget build(BuildContext context) {
    tourInfo = FakeData.tourInfo;
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Tạo chuyến đi',
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: _SliverCreateTourAppBarDelegate(tourInfo),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            ProgressBar(),
            Expanded(
              child: ExtendedPageView(
                controller: pageController,
                cacheExtent: 3,
                children: <Widget>[
                  buildTab1(),
                  buildTab2(),
                  buildTab3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildTab1() {
    return BorderContainer(
      key: GlobalKey(),
      title: 'Tab1',
    );
  }

  buildTab2() {
    return BorderContainer(
      key: GlobalKey(),
      title: 'Tab1',
    );
  }

  buildTab3() {
    return BorderContainer(
      key: GlobalKey(),
      title: 'Tab1',
    );
  }
}

class _SliverCreateTourAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 175;
  final double minHeight = 50;
  final TourInfo tourInfo;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  _SliverCreateTourAppBarDelegate(
    this.tourInfo, {
    this.snapConfiguration,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CreateTourSlider(tourInfo: tourInfo);
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
