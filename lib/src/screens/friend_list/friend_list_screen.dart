part of '../screens.dart';

class FriendListScreenArgs {
  final SimpleUser user;

  FriendListScreenArgs(this.user);
}

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen>
    with SingleTickerProviderStateMixin {
  final tabList = ['Lời mời', 'Bạn bè'];
  TabController _tabController;
  SimpleUser user;
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabList.length);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        user =
            (ModalRoute.of(context).settings.arguments as FriendListScreenArgs)
                ?.user;
        isCurrentUser =
            user == null || CurrentUserBloc().isCurrentUser(simpleUser: user);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Bạn bè',
        bottom: isCurrentUser
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
      body: isCurrentUser
          ? ExtendedTabBarView(
              controller: _tabController,
              cacheExtent: isCurrentUser ? 2 : 1,
              children: [
                CurrentUserBloc().requestedFriendsBloc,
                CurrentUserBloc().acceptedFriendsBloc
              ].map(buildList).toList(),
            )
          : buildList(UserFriendsBloc.forOtherUser(user)),
    );
  }

  Widget buildList(UserFriendsBloc bloc) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is FriendsStateSuccess && bloc.friendList.length == 0) {
          return NotFoundWidget(
            message: 'Hiện tại không có lời mời kết bạn nào.',
            bottom: PrimaryButton(
              title: Strings.button.findFriendNow,
            ),
          );
        } else if (state is UserFriendsStateFailure) {
          return ErrorIndicator(
            message: Strings.error.errorClick,
            moreErrorDetail: state.error,
            onReload: () {
              bloc.add(UserFriendsEventFirstFetch());
            },
          );
        } else if (state is UserFriendsStateLoadMoreFailure) {
          showErrorMessage(state.error);
        }

        return FriendListWidget(
          friends: bloc.friendList,
          readonly: !isCurrentUser,
          isLoading: state is UserFriendsStateLoading,
          canLoadmore: bloc.pagination?.canLoadmore ?? false,
          onFirstFetch: () {
            bloc.add(UserFriendsEventFirstFetch());
          },
          onLoadingMore: () {
            bloc.add(UserFriendsEventLoadMore());
          },
        );
      },
    );
  }
}
