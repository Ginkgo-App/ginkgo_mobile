import 'package:base/base.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_point_tab_bar/pointTabIndicator.dart';
import 'package:ginkgo_mobile/src/screens/friend_list_page/widgets/friend_list_tab.dart';
import 'package:ginkgo_mobile/src/screens/friend_list_page/widgets/request_friend_tab.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen>
    with SingleTickerProviderStateMixin {
  final tabList = ['Lời mời (10)', 'Bạn bè'];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Friend',
        showBackButton: true,
        bottom: TabBar(
          unselectedLabelColor: DesignColor.tinyItems,
          labelColor: context.colorScheme.onBackground,
          controller: _tabController,
          indicator: PointTabIndicator(
            position: PointTabIndicatorPosition.bottom,
            color: Colors.pink,
            insets: EdgeInsets.only(bottom: 6),
          ),
          tabs: tabList.map((item) {
            return Tab(
              text: item,
            );
          }).toList(),
        ),
      ),
      body: ExtendedTabBarView(
        controller: _tabController,
        linkWithAncestor: true,
        children: [RequestFriendTab(),FriendListTab()],
      ),
    );
  }
}
