part of '../screens.dart';

class HomeScreenArgs {
  final int tabIndex;

  const HomeScreenArgs({this.tabIndex = 0});
}

class HomeScreen extends StatefulWidget {
  final HomeScreenArgs args;

  const HomeScreen({Key key, this.args = const HomeScreenArgs()})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _cIndex;
  TabController _tabController;

  final _pages = [
    HomePage(),
    Container(),
    ProfilePage(),
    Container(),
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppConfig.instance.appName),
          SizedBox(
            height: 20,
          ),
          PrimaryButton(
            title: Strings.button.logout,
            onPressed: () {
              AuthBloc().add(AuthEventLogout());
            },
          )
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cIndex = widget.args.tabIndex;
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.animateTo(_cIndex);
    _tabController.addListener(() {
      setState(() {
        _cIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      bottomNavigationBar: _buildBottomNavigator(context),
      body: HomeProvider(
        context,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _pages,
        ),
      ),
    );
  }

  _buildBottomNavigator(BuildContext context) {
    final colorScheme = context.colorScheme;
    return BottomNavigationBar(
      backgroundColor: colorScheme.background,
      elevation: 10,
      onTap: (int index) {
        setState(() {
          _cIndex = index;
          _tabController.animateTo(index);
        });
      },
      currentIndex: _cIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.icons.homeOutline,
            color: colorScheme.onBackground,
            height: 24,
          ),
          title: Container(),
          activeIcon: SvgPicture.asset(
            Assets.icons.homeFull,
            color: colorScheme.primary,
            height: 24,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.icons.tripOutline,
            color: colorScheme.onBackground,
            height: 24,
          ),
          title: Container(),
          activeIcon: SvgPicture.asset(
            Assets.icons.tripFull,
            color: colorScheme.primary,
            height: 24,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.icons.meOutline,
            color: colorScheme.onBackground,
            height: 24,
          ),
          title: Container(),
          activeIcon: SvgPicture.asset(
            Assets.icons.meFull,
            color: colorScheme.primary,
            height: 24,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.icons.notiOutline,
            color: colorScheme.onBackground,
            height: 24,
          ),
          title: Container(),
          activeIcon: SvgPicture.asset(
            Assets.icons.notiFull,
            color: colorScheme.primary,
            height: 24,
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.icons.settingOutline,
            color: colorScheme.onBackground,
            height: 24,
          ),
          title: Container(),
          activeIcon: SvgPicture.asset(
            Assets.icons.settingFull,
            color: colorScheme.primary,
            height: 24,
          ),
        ),
      ],
    );
  }
}
