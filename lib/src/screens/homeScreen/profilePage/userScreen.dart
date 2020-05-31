part of '../../screens.dart';

class UserScreenArgs {
  final SimpleUser simpleUser;

  UserScreenArgs(this.simpleUser);
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserBloc userBloc = UserBloc();
  UserScreenArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context).settings.arguments;
      if (args?.simpleUser != null) {
        setState(() {
          _fetchUserInfo();
        });
      } else {
        Navigator.pop(context);
      }
    });
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
                            UserNav(),
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
                              TourListWidget(userId: user.id),
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
