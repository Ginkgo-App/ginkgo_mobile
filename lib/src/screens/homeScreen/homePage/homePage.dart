import 'package:base/base.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homePage/widgets/homeSliverAppBar.dart';
import 'package:ginkgo_mobile/src/screens/profileScreen/widgets/activityBox.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final tabList = ['Khám phá', 'Bảng tin'];
  TabController _tabController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, _) {
          return [
            SliverPersistentHeader(
              floating: false,
              pinned: true,
              delegate: HomeSliverAppBarDelegate(
                  expandedHeight: 206,
                  bottom: PreferredSize(
                      child: Center(
                        child: TabBar(
                          controller: _tabController,
                          tabs: tabList.map((item) {
                            return Tab(
                              text: item,
                            );
                          }).toList(),
                          onTap: (i) {
                            _tabController.animateTo(i);
                          },
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
                                width: 2, color: context.colorScheme.primary),
                          ),
                        ),
                      ),
                      preferredSize: Size.fromHeight(50))),
            )
          ];
        },
        body: ExtendedTabBarView(
          controller: _tabController,
          linkWithAncestor: true,
          children: [
            CustomScrollView(
              key: GlobalKey(),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  FlutterLogo(),
                  FlutterLogo(),
                  FlutterLogo(),
                  FlutterLogo(),
                ]))
              ],
            ),
            CustomScrollView(
              key: GlobalKey(),
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                  ActivityBox(),
                ]))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
