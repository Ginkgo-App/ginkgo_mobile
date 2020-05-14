import 'dart:math';

import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/widgets/customs/customTabBar.dart' as custom;
import 'package:ginkgo_mobile/src/widgets/gradientOutlineBorder.dart';
import 'package:ginkgo_mobile/src/widgets/logoWidget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final tabList = ['Khám phá', 'Bảng tin'];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: _HomeSliverAppBar(expandedHeight: 206),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: TabBar(
                  controller: _tabController,
                  tabs: tabList.map((item) {
                    return Tab(
                      text: item,
                    );
                  }).toList(),
                  indicatorColor: context.colorScheme.primary,
                  labelColor: context.colorScheme.onBackground,
                  labelStyle: context.textTheme.caption
                      .copyWith(fontWeight: FontWeight.bold),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                      insets: EdgeInsets.only(bottom: 10),
                      borderSide: BorderSide(
                          width: 2, color: context.colorScheme.primary)),
                ),
              ),
              BorderContainer(
                title: 'Something',
              ),
              custom.CustomTabBarView(
                controller: _tabController,
                children: tabList.map((item) {
                  return Container(color: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1), child: Center(child: Text(item)));
                }).toList(),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class _HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  static const LOGO_MAX_SIZE = 130;
  static const LOGO_MIN_SIZE = 60;

  _HomeSliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final logoMarginLeft =
        (MediaQuery.of(context).size.width - LOGO_MAX_SIZE) / 2;
    final rate = shrinkOffset / expandedHeight;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Positioned(
          left: -186,
          right: -186,
          top: -58 - 122 * rate,
          child: Container(
            width: 742,
            height: 264,
            decoration: BoxDecoration(
                color: DesignColor.lightPink,
                borderRadius: BorderRadius.all(Radius.elliptical(742, 264))),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 20,
          child: Opacity(
            opacity: (1 - rate),
            child: Image.asset(Assets.images.homeLeafs),
          ),
        ),
        Positioned(
          left: 12 + 68 * rate,
          right: 12,
          top: 140 - 125 * rate,
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Color(0xffE4D8D8), width: 1),
              boxShadow: DesignColor.defaultDropShadow,
              borderRadius: BorderRadius.circular(5),
              color: context.colorScheme.background,
            ),
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                  border: GradientOutlineInputBorder(
                    borderSide: BorderSide.none,
                    focusedGradient: GradientColor.of(context).primaryGradient,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(Assets.icons.search),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  hintText: 'Tìm kiếm...'),
            ),
          ),
        ),
        Positioned(
          left: logoMarginLeft - ((logoMarginLeft - 5) * rate),
          top: 5,
          child: LogoWidget(
            width: LOGO_MAX_SIZE - LOGO_MIN_SIZE * rate,
            height: LOGO_MAX_SIZE - LOGO_MIN_SIZE * rate,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
