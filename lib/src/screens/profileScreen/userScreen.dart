part of '../screens.dart';

class UserScreenArgs {
  final int userId;

  UserScreenArgs(this.userId);
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserBloc _bloc = UserBloc();
  int userId;

  @override
  void initState() {
    super.initState();

    final UserScreenArgs args = ModalRoute.of(context).settings.arguments;
    if (args?.userId != null) {
      userId = args.userId;
    } else {
      Navigator.pop(context);
    }
  }

  _fetchUserInfo() {
    _bloc.add(UserEventFetch(userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        User user = User(fullName: 'Loading', avatar: '');
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
                            FriendList(),
                            const SizedBox(height: 10),
                            InfoBox(),
                            const SizedBox(height: 10),
                            TourListWidget(),
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
