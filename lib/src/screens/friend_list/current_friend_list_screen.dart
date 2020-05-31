part of '../screens.dart';

class CurrentFriendListScreen extends StatefulWidget {
  @override
  _CurrentFriendListScreenState createState() =>
      _CurrentFriendListScreenState();
}

class _CurrentFriendListScreenState extends State<CurrentFriendListScreen>
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
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Bạn bè',
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
        cacheExtent: 2,
        children: [
          CurrentUserBloc().requestedFriendsBloc,
          CurrentUserBloc().acceptedFriendsBloc
        ]
            .map(
              (bloc) => BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is CurrentUserFriendsStateSuccess &&
                      bloc.friendList.length == 0) {
                    return NotFoundWidget(
                      message: 'Hiện tại không có lời mời kết bạn nào.',
                      bottom: PrimaryButton(
                        title: Strings.button.findFriendNow,
                      ),
                    );
                  } else if (state is CurrentUserFriendsStateFailure) {
                    return ErrorIndicator(
                      message: Strings.error.errorClick,
                      moreErrorDetail: state.error,
                      onReload: () {
                        bloc.add(CurrentUserFriendsEventFirstFetch());
                      },
                    );
                  }

                  return FriendListWidget(
                    friends: bloc.friendList,
                    isLoading: state is CurrentUserFriendsStateLoading,
                    isLoadingMore: state is CurrentUserFriendsStateLoadingMore,
                    onFirstFetch: () {
                      bloc.add(CurrentUserFriendsEventFirstFetch());
                    },
                    onLoadingMore: () {
                      bloc.add(CurrentUserFriendsEventLoadMore());
                    },
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
