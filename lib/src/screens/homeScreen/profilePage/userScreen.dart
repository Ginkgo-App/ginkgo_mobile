part of '../../screens.dart';

class UserScreenArgs {
  final SimpleUser simpleUser;

  UserScreenArgs(this.simpleUser);
}

class UserScreen extends StatefulWidget {
  final UserScreenArgs args;

  const UserScreen({Key key, this.args}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with LoadDataScreenMixin, LoadmoreMixin {
  final UserBloc _userBloc = UserBloc();
  UserFriendsBloc _userFriendsBloc;
  PostListBloc _postListBloc;
  UserScreenArgs args;

  @override
  void initState() {
    super.initState();
    args = widget.args;

    _userFriendsBloc = UserFriendsBloc.forOtherUser(args?.simpleUser);
    _postListBloc = PostListBloc(3, userId: args?.simpleUser?.id);
    loadData();
  }

  loadData() async {
    await _loadInfo();
    await _loadFriend();
    _postListBloc?.add(PostListEventFetch());
  }

  _loadInfo() async {
    _userBloc.add(UserEventFetch(args?.simpleUser?.id));
    await _userBloc.waitOne([UserStateFailure, UserStateSuccess]);
  }

  _loadFriend() async {
    _userFriendsBloc.add(UserFriendsEventFirstFetch());
    await _userFriendsBloc
        .waitOne([UserFriendsStateFailure, UserFriendsStateSuccess]);
  }

  onLoadMore() {
    _postListBloc?.add(PostListEventLoadMore());
  }

  dispose() {
    _postListBloc.close();
    _userBloc.close();
    _userFriendsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _userBloc,
      builder: (context, state) {
        User user = User(
            fullName: args?.simpleUser?.name ?? '',
            avatar: args?.simpleUser?.avatar);
        if (state is UserStateSuccess) {
          user = state.user;
          user.friendType = args?.simpleUser?.friendType;
        }

        return PrimaryScaffold(
          isLoading: state is UserStateLoading,
          appBar: BackAppBar(title: user.fullName),
          body: state is CurrentUserStateFailure
              ? ErrorIndicator(
                  moreErrorDetail: state.error,
                  onReload: loadData,
                )
              : ListView(
                  controller: scrollController,
                  itemExtent: null,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    AvatarWidget(user: user),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          UserNav(
                              user: user?.toSimpleUser() ?? args?.simpleUser,
                              onFriendActionSuccess: () {
                                loadData();
                              }),
                          const SizedBox(height: 10),
                          AboutBox(user: user),
                          const SizedBox(height: 10),
                          if (user?.id != null) ...[
                            FriendList(
                              userFriendsBloc: _userFriendsBloc,
                              onShowAll: () {
                                showErrorMessage(
                                    Strings.common.developingFeature);
                              },
                              onReload: _loadFriend,
                            ),
                            const SizedBox(height: 10),
                          ],
                          InfoBox(user: user),
                          const SizedBox(height: 10),
                          if (user?.id != null) ...[
                            TourListWidget(user: user?.toSimpleUser()),
                            const SizedBox(height: 10),
                          ],
                          ActivityBox(postListBloc: _postListBloc),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
