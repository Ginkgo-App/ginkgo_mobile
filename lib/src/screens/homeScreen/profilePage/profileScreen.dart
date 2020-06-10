part of '../../screens.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CurrentUserBloc _bloc = CurrentUserBloc();

  StreamSubscription currentUserListener;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    if (_bloc.currentUser == null && _bloc.state is! CurrentUserStateLoading) {
      _fetchProfile();
    }

    currentUserListener = _bloc.listen((state) {
      if (state is CurrentUserStateLoading) {
        LoadingManager().show(context);
      } else {
        LoadingManager().hide(context);
      }
    });
  }

  _fetchProfile() {
    _bloc.add(CurrentUserEventFetch());
  }

  _onChangeProfile() {
    setState(() {
      editMode = !editMode;
    });
  }

  @override
  void dispose() {
    currentUserListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, state) {
        User user;
        if (state is CurrentUserStageSuccess ||
            state is CurrentUserStateHaveChanges) {
          user = _bloc.currentUser;
        }

        return PrimaryScaffold(
          appBar: BackAppBar(
            title: user?.fullName ?? '',
            showBackButton: false,
          ),
          body: state is CurrentUserStateFailure
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
                            OwnerNav(
                              onCustomButtonPressed: () => _showMenuBottomSheet(
                                  HomeProvider.of(context).context, user),
                            ),
                            const SizedBox(height: 10),
                            AboutBox(user: user, editMode: editMode),
                            const SizedBox(height: 10),
                            FriendList(user: user?.toSimpleUser()),
                            const SizedBox(height: 10),
                            InfoBox(user: user, editMode: editMode),
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

  _showMenuBottomSheet(BuildContext context, User user) {
    showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.8, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          duration: const Duration(milliseconds: 200),
          builder: (context, state) {
            return Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  {
                    'text': !editMode
                        ? 'Chỉnh sửa thông tin cá nhân'
                        : 'Tắt chỉnh sửa',
                    'onPressed': () {
                      Navigator.pop(context);
                      _onChangeProfile();
                    }
                  },
                  {
                    'text': 'Chỉnh sửa câu giới thiệu',
                    'onPressed': () {
                      Navigator.pop(context);
                      showSloganBottomSheet(context, user.slogan);
                    }
                  },
                ]
                    .map<Widget>(
                      (e) => FlatButton(
                        child: Text(e['text'], style: context.textTheme.body1),
                        color: context.colorScheme.background,
                        highlightColor: DesignColor.darkestWhite,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: e['onPressed'],
                      ),
                    )
                    .toList()
                    .addBetweenEvery(
                      Container(
                        height: 0.5,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: DesignColor.lightestBlack,
                      ),
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
