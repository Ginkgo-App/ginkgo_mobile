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

class _UserScreenState extends State<UserScreen> {
  final UserBloc userBloc = UserBloc();
  UserScreenArgs args;

  @override
  void initState() {
    super.initState();
    args = widget.args;
  }

  _fetchUserInfo() {
    userBloc.add(UserEventFetch(args?.simpleUser?.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: userBloc,
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
                  onReload: _fetchUserInfo,
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AvatarWidget(user: user),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            UserNav(
                                user: user.toSimpleUser(),
                                onFriendActionSuccess: () {
                                  _fetchUserInfo();
                                }),
                            const SizedBox(height: 10),
                            AboutBox(user: user),
                            const SizedBox(height: 10),
                            if (user?.id != null) ...[
                              FriendList(user: args.simpleUser),
                              const SizedBox(height: 10),
                            ],
                            InfoBox(user: user),
                            const SizedBox(height: 10),
                            if (user?.id != null) ...[
                              TourListWidget(user: user?.toSimpleUser()),
                              const SizedBox(height: 10),
                            ],
                            ActivityBox(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
