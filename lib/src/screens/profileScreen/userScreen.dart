part of '../screens.dart';

class UserScreenArgs {
  final SimpleUser simpleUser;

  UserScreenArgs(this.simpleUser);
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserBloc _bloc = UserBloc();
  SimpleUser simpleUser;

  @override
  void initState() {
    super.initState();

    final UserScreenArgs args = ModalRoute.of(context).settings.arguments;
    if (args?.simpleUser != null) {
      simpleUser = args.simpleUser;
    } else {
      Navigator.pop(context);
    }
  }

  _fetchUserInfo() {
    _bloc.add(UserEventFetch(simpleUser.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        User user = User(fullName: simpleUser.name, avatar: simpleUser.avatar);
        if (state is UserStateSuccess) {
          user = state.user;
        }

        return PrimaryScaffold(
          isLoading: state is UserStateLoading,
          appBar: BackAppBar(title: user.fullName),
          body: state is CurrentUserFailure
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
                            OwnerNav(),
                            const SizedBox(height: 10),
                            AboutBox(user: user),
                            const SizedBox(height: 10),
                            FriendList(userId: simpleUser.id),
                            const SizedBox(height: 10),
                            InfoBox(user: user),
                            const SizedBox(height: 10),
                            TourListWidget(userId: simpleUser.id),
                            const SizedBox(height: 10),
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
