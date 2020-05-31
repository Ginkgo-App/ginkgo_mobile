part of '../screens.dart';

class FriendListScreenArgs {
  final SimpleUser user;

  FriendListScreenArgs(this.user);
}

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<CurrentFriendListScreen>
    with SingleTickerProviderStateMixin {
  final tabList = ['Lời mời', 'Bạn bè'];
  TabController _tabController;
  SimpleUser user;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    final isCurrenUser = CurrentUserBloc().isCurrentUser(simpleUser: user);
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Bạn bè',
        showBackButton: true,
        bottom: isCurrenUser
            ? TabBar(
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
              )
            : null,
      ),
      body: ExtendedTabBarView(
        controller: _tabController,
        cacheExtent: 2,
        children: [
          BlocBuilder(
            bloc: UserFriendBloc(),
            builder: (context, state) {
              if (state is UserFriendStateSuccess &&
                  UserFriendBloc().friendList.pagination.totalElement == 0) {
                return NotFoundWidget(
                  message: 'Hiện tại không có lời mời kết bạn nào.',
                  bottom: PrimaryButton(
                    title: Strings.button.findFriendNow,
                  ),
                );
              }
              return FriendListWidget(
                friends: UserFriendBloc().friendList.data,
              );
            },
          ),
        ],
      ),
    );
  }
}
