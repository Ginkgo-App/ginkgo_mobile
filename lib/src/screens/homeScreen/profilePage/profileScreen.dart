part of '../../screens.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with LoadDataScreenMixin, LoadmoreMixin {
  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();
  final PostListBloc _postListBloc = PostListBloc(3, userId: 0);
  final GlobalKey activityBoxKey = GlobalKey(debugLabel: 'activityBoxKey');

  bool editMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_currentUserBloc.currentUser == null &&
          _currentUserBloc.state is! CurrentUserStateLoading) {
        loadDataController
            .loadData()
            .then((value) => _checkScrollToActivityBox());
      } else {
        loadDataController
            .loadDataForWidget()
            .then((value) => _checkScrollToActivityBox());
      }
    });
  }

  @override
  loadData() {
    _currentUserBloc.add(CurrentUserEventFetch());
    _postListBloc.add(PostListEventFetch());
  }

  onLoadMore() {
    _postListBloc.add(PostListEventLoadMore());
  }

  _onChangeProfile() {
    setState(() {
      editMode = !editMode;
    });
  }

  _checkScrollToActivityBox() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final homeProvider = HomeProvider.of(context);
      if (homeProvider != null && homeProvider.scrollProfileToActivityBox) {
        Scrollable.ensureVisible(
          activityBoxKey.currentContext,
          duration: Duration(milliseconds: 200),
        );
      }
    });
  }

  dispose() {
    _postListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _currentUserBloc,
      builder: (context, state) {
        User user;
        if (state is CurrentUserStateSuccess ||
            state is CurrentUserStateHaveChanges) {
          user = _currentUserBloc.currentUser;
        }

        return PrimaryScaffold(
          appBar: BackAppBar(title: user?.fullName ?? ''),
          loadDataController: loadDataController,
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
                    AvatarWidget(user: user, editable: true),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          OwnerNav(
                            onCreatePostPressed: () => Navigators
                                .appNavigator.currentState
                                .pushNamed(Routes.createPost),
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
                          TourListWidget(user: user?.toSimpleUser()),
                          const SizedBox(height: 10),
                          ActivityBox(
                            key: activityBoxKey,
                            postListBloc: _postListBloc,
                          ),
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
                  {
                    'text': 'Đăng xuất',
                    'onPressed': () {
                      Navigator.pop(context);
                      AuthBloc().add(AuthEventLogout());
                    }
                  },
                ]
                    .map<Widget>(
                      (e) => FlatButton(
                        child:
                            Text(e['text'], style: context.textTheme.bodyText2),
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
