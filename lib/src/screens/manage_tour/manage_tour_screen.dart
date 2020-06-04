part of '../screens.dart';

class ManageTourScreen extends StatefulWidget {
  @override
  _ManageTourScreenState createState() => _ManageTourScreenState();
}

class _ManageTourScreenState extends State<ManageTourScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  onOpenCreateTour() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {}, child: Text('Tạo mẫu chuyến đi')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigators.appNavigator.currentState
                        .pushNamed(Routes.createTour);
                  },
                  child: Text('Tạo chuyến đi')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Quản lý chuyến đi',
        actions: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.add,
              size: 30,
              color: context.colorScheme.onBackground,
            ),
            onPressed: onOpenCreateTour,
          )
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    expandedHeight: 80,
                    minHeight: 40,
                    selecteds: [currentPage == 0, currentPage == 1],
                    onChanged: (int index) {
                      if (index != currentPage) {
                        setState(() {
                          currentPage = index;
                        });
                        pageController.animateToPage(currentPage,
                            duration: Duration(seconds: 1), curve: Curves.ease);
                      }
                    }),
              ),
            ];
          },
          body: PageView(
            controller: pageController,
            onPageChanged: (i) {
              setState(() {
                currentPage = i;
              });
            },
            children: <Widget>[
              SingleChildScrollView(
                child: BorderContainer(
                  childPadding: EdgeInsets.zero,
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: IntrinsicHeight(
                      child: SpacingColumn(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        isSpacingHeadTale: true,
                        children: [
                          ...List.generate(5, (_) => FakeData.simpleTour)
                              .map((e) => TripItem(tour: e))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: BorderContainer(
                  childPadding: EdgeInsets.zero,
                  margin: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: IntrinsicHeight(
                      child: SpacingColumn(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        isSpacingHeadTale: true,
                        children: [
                          ...List.generate(5, (_) => FakeData.simpleTour)
                              .map((e) => TripItem(tour: e))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final List<bool> selecteds;
  final Function(int) onChanged;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  _SliverAppBarDelegate({
    @required this.selecteds,
    @required this.expandedHeight,
    @required this.minHeight,
    this.onChanged,
    this.snapConfiguration,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));
    final radius = 5 - 5 * scrollRate;

    return Container(
      height: expandedHeight - scrollRate * (expandedHeight - minHeight),
      child: Center(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width - 60 * (1 - scrollRate),
          decoration: BoxDecoration(
            boxShadow: DesignColor.defaultDropShadow,
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              'Chuyến đi bạn tham gia',
              'Chuyến đi bạn tổ chức',
            ]
                .asMap()
                .map(
                  (i, e) => MapEntry(
                    i,
                    Expanded(
                      child: InkWell(
                        onTap: () => onChanged(i),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(i == 0 ? radius : 0),
                              right: Radius.circular(i == 1 ? radius : 0),
                            ),
                            color: selecteds[i]
                                ? context.colorScheme.primary
                                : context.colorScheme.onPrimary,
                          ),
                          child: Center(
                            child: Text(
                              e,
                              style: context.textTheme.body1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selecteds[i]
                                    ? context.colorScheme.onPrimary
                                    : context.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
