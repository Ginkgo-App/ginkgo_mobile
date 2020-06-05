part of '../screens.dart';

class CreateTourScreen extends StatefulWidget {
  final TourInfo tourInfo;

  const CreateTourScreen({Key key, this.tourInfo}) : super(key: key);

  @override
  _CreateTourScreenState createState() => _CreateTourScreenState();
}

class _CreateTourScreenState extends State<CreateTourScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  TourInfo tourInfo;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  validateTab() {
    return true;
  }

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
                  child: ProgressBar(
                    currentIndex: currentStep,
                    onPageChanged: (i) {
                      if (i - currentStep < 2 && validateTab()) {
                        setState(() {
                          currentStep = i;
                          tabController.animateTo(i);
                        });
                      }
                    },
                  ),
                  preferredSize: Size.fromHeight(110),
                ),
              ),
            ),
          ];
        },
        body: ExtendedTabBarView(
          controller: tabController,
          cacheExtent: 3,
          physics: NeverScrollableScrollPhysics(),
          linkWithAncestor: true,
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
    return Column(
      children: <Widget>[
        BorderContainer(
          child: CreateTourTab1(),
        ),
      ],
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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            DesignColor.lighterPink,
            Color(0xfffff2ee),
            Color(0xfffff2ee).withOpacity(0),
          ],
          stops: [0, 0.95, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height:
                  expandedHeight - (expandedHeight - minHeight) * scrollRate,
              child: CreateTourSlider(
                tourInfo: tourInfo,
                height: height,
              ),
            ),
            if (bottom != null) bottom
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  double get minExtent => minHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
