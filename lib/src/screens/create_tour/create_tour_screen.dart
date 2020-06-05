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
              delegate: _SliverCreateTourAppBarDelegate(
                tourInfo,
                bottom: PreferredSize(
                  child: ProgressBar(),
                  preferredSize: Size.fromHeight(150),
                ),
              ),
            ),
          ];
        },
        body: ExtendedPageView(
          controller: pageController,
          cacheExtent: 3,
          children: <Widget>[
            buildTab1(),
            buildTab2(),
            buildTab3(),
          ],
        ),
      ),
    );
  }

  buildTab1() {
    return BorderContainer(
      child: CreateTourTab1(),
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
  final PreferredSizeWidget bottom;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  _SliverCreateTourAppBarDelegate(
    this.tourInfo, {
    this.snapConfiguration,
    this.bottom,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));
    final height = maxExtent - (maxExtent - minExtent) * scrollRate;

    return CreateTourSlider(
      tourInfo: tourInfo,
      height: height,
    );
  }

  @override
  double get maxExtent => expandedHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
