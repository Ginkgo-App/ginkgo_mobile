part of '../../screens.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CurrentUserBloc _bloc = CurrentUserBloc();
  StreamSubscription currentUserListener;
  StreamSubscription updateUserListener;

  @override
  void initState() {
    super.initState();
    if (_bloc.currentUser == null && _bloc.state is! CurrentUserLoading) {
      _fetchProfile();
    }

    currentUserListener = _bloc.listen((state) {
      if (state is CurrentUserLoading) {
        LoadingManager().show(context);
      } else {
        LoadingManager().hide(context);
      }
    });

    updateUserListener = UpdateProfileBloc().listen((state) {
      if (state is UpdateProfileStateLoading) {
        LoadingManager().show(context);
      } else {
        if (state is UpdateProfileStateFailure) {
          Toast.show(state.error, context);
        }
        LoadingManager().hide(context);
      }
    });
  }

  _fetchProfile() {
    _bloc.add(CurrentUserEventFetch());
  }

  @override
  void dispose() {
    currentUserListener.cancel();
    updateUserListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        User user;
        if (state is CurrentUserSuccess) {
          user = state.currentUser;
        }

        return PrimaryScaffold(
          appBar: BackAppBar(
            title: user?.fullName ?? '',
            showBackButton: false,
          ),
          body: state is CurrentUserFailure
              ? ErrorIndicator(
                  moreErrorDetail: state.error,
                  onReload: () {
                    _bloc.add(CurrentUserEventFetch());
                  },
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AvatarWidget(user: user, editable: true),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: <Widget>[
                            OwnerNav(),
                            const SizedBox(height: 10),
                            AboutBox(user: user),
                            const SizedBox(height: 10),
                            FriendList(userId: 0),
                            const SizedBox(height: 10),
                            InfoBox(user: user),
                            const SizedBox(height: 10),
                            TourListWidget(userId: 0),
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
