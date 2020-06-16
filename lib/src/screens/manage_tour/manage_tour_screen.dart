part of '../screens.dart';

class ManageTourScreen extends StatefulWidget {
  @override
  _ManageTourScreenState createState() => _ManageTourScreenState();
}

enum _Filter { tourInfo, tour }

class _ManageTourScreenState extends State<ManageTourScreen>
    with TickerProviderStateMixin, LoadmoreMixin {
  static const _PAGE_SIZE = 3;

  final PageController _pageController = PageController();
  final TourListBloc _memberTourListBloc = TourListBloc(_PAGE_SIZE);
  final TourListBloc _ownerTourListBloc = TourListBloc(_PAGE_SIZE);
  final TourInfoListBloc _ownerTourInfoListBloc = TourInfoListBloc(_PAGE_SIZE);

  int _currentPage = 0;
  _Filter _filter = _Filter.tour;

  initState() {
    super.initState();

    _fetchData();
  }

  _fetchData() {
    _fetchMemberTourList();
    _fetchOwnerTourList();
    _fetchOwnerTourInfoList();
  }

  @override
  onLoadMore() {
    if (_currentPage == 0) {
      _fetchMemberTourList();
    } else {
      if (_filter == _Filter.tour) {
        _fetchOwnerTourList();
      } else {
        _fetchOwnerTourInfoList();
      }
    }
  }

  _fetchMemberTourList() {
    if (_memberTourListBloc.state is! TourListStateLoading) {
      _memberTourListBloc.add(TourListEventFetchOfMe(type: MeTourType.member));
    }
  }

  _fetchOwnerTourList() {
    if (_ownerTourListBloc.state is! TourListStateLoading) {
      _ownerTourListBloc.add(TourListEventFetchOfMe(type: MeTourType.owner));
    }
  }

  _fetchOwnerTourInfoList() {
    if (_ownerTourInfoListBloc.state is! TourInfoListStateLoading) {
      _ownerTourInfoListBloc.add(TourInfoListEventFetch());
    }
  }

  openSelectFilter() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_filter != _Filter.tourInfo) {
                      setState(() {
                        _filter = _Filter.tourInfo;
                      });
                    }
                  },
                  child: Text('Mẫu chuyến đi')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    if (_filter != _Filter.tour) {
                      setState(() {
                        _filter = _Filter.tour;
                      });
                    }
                  },
                  child: Text('Chuyến đi cụ thể')),
            ],
          );
        });
  }

  dispose() {
    _pageController.dispose();
    _memberTourListBloc.close();
    _ownerTourListBloc.close();
    _ownerTourInfoListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Quản lý chuyến đi'),
      bottomPadding: false,
      bottomNavigationBar: _buildBottomButton(),
      body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, _) {
            return [
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    expandedHeight: 80,
                    minHeight: 40,
                    selecteds: [_currentPage == 0, _currentPage == 1],
                    onChanged: (int index) {
                      if (index != _currentPage) {
                        setState(() {
                          _currentPage = index;
                        });
                        _pageController.animateToPage(_currentPage,
                            duration: Duration(seconds: 1), curve: Curves.ease);
                      }
                    }),
              ),
            ];
          },
          body: PageView(
            controller: _pageController,
            onPageChanged: (i) {
              setState(() {
                _currentPage = i;
              });
            },
            children: <Widget>[
              SingleChildScrollView(
                child: BorderContainer(
                  margin: const EdgeInsets.all(10),
                  children: <Widget>[
                    const SizedBox(height: 10),
                    BlocBuilder(
                      bloc: _memberTourListBloc,
                      builder: (context, state) {
                        if (state is TourListStateFailure) {
                          return ErrorIndicator(
                            message: Strings.error.errorClick,
                            moreErrorDetail: state.error.toString(),
                            onReload: _fetchMemberTourList,
                          );
                        }

                        return ManageTourList(
                          tours: _memberTourListBloc.tourList.data,
                          onLoadmore: _fetchMemberTourList,
                          isLoading: state is TourListStateLoading,
                        );
                      },
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: BorderContainer(
                  title: _filter == _Filter.tour
                      ? 'Chuyến đi cụ thể'
                      : 'Khuôn mẫu chuyến đi',
                  actions: <Widget>[
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: openSelectFilter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                            boxShadow: DesignColor.buttonShadow,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2)),
                        child: Row(
                          children: <Widget>[
                            GradientText(
                              'Lọc',
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffFDC70C),
                                  Color(0xffF3903F),
                                  Color(0xffED683C),
                                  Color(0xffE93E3A),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              style: context.textTheme.button
                                  .copyWith(color: Colors.white),
                            ),
                            SvgPicture.asset(Assets.icons.filter),
                          ],
                        ),
                      ),
                    )
                  ],
                  margin: const EdgeInsets.all(10),
                  child: _filter == _Filter.tour
                      ? BlocBuilder(
                          bloc: _ownerTourListBloc,
                          builder: (context, state) {
                            if (state is TourListStateFailure) {
                              return ErrorIndicator(
                                message: Strings.error.errorClick,
                                moreErrorDetail: state.error.toString(),
                                onReload: _fetchOwnerTourList,
                              );
                            }

                            return ManageTourList(
                              tours: _ownerTourListBloc.tourList.data,
                              onLoadmore: _fetchOwnerTourList,
                              isLoading: state is TourListStateLoading,
                            );
                          },
                        )
                      : BlocBuilder(
                          bloc: _ownerTourInfoListBloc,
                          builder: (context, state) {
                            if (state is TourInfoListStateFailure) {
                              return ErrorIndicator(
                                message: Strings.error.errorClick,
                                moreErrorDetail: state.error.toString(),
                                onReload: _fetchOwnerTourInfoList,
                              );
                            }

                            return ManageTourList(
                              tourInfos:
                                  _ownerTourInfoListBloc.tourInfoList.data,
                              onLoadmore: _fetchOwnerTourInfoList,
                              isLoading: state is TourInfoListStateLoading,
                            );
                          },
                        ),
                ),
              ),
            ],
          )),
    );
  }

  _buildBottomButton() {
    return Column(
      children: <Widget>[
        AnimatedSize(
          duration: Duration(milliseconds: 200),
          vsync: this,
          child: Container(
            padding: EdgeInsets.all(_currentPage == 0 ? 0 : 10),
            child: _currentPage == 0
                ? const SizedBox.shrink()
                : PrimaryButton(
                    title: _filter == _Filter.tour
                        ? 'Tạo thêm chuyến đi'
                        : 'Tạo thêm khuôn mẫu',
                    width: double.maxFinite,
                    onPressed: () {
                      if (_filter == _Filter.tour) {
                        Navigators.appNavigator.currentState
                            .pushNamed(Routes.createTour);
                      } else {
                        Navigators.appNavigator.currentState
                            .pushNamed(Routes.createTourInfo);
                      }
                    },
                  ),
          ),
        ),
        if (_currentPage != 0) const SizedBox(height: 30)
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  final List<bool> selecteds;
  final Function(int) onChanged;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  _SliverAppBarDelegate({
    @required this.selecteds,
    @required this.expandedHeight,
    @required this.minHeight,
    this.onChanged,
    this.snapConfiguration,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));
    final radius = 5 - 5 * scrollRate;

    return Container(
      height: expandedHeight - scrollRate * (expandedHeight - minHeight),
      child: Center(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width - 60 * (1 - scrollRate),
          decoration: BoxDecoration(
            boxShadow: DesignColor.defaultDropShadow,
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              'Chuyến đi bạn tham gia',
              'Chuyến đi bạn tổ chức',
            ]
                .asMap()
                .map(
                  (i, e) => MapEntry(
                    i,
                    Expanded(
                      child: InkWell(
                        onTap: () => onChanged(i),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(i == 0 ? radius : 0),
                              right: Radius.circular(i == 1 ? radius : 0),
                            ),
                            color: selecteds[i]
                                ? context.colorScheme.primary
                                : context.colorScheme.onPrimary,
                          ),
                          child: Center(
                            child: Text(
                              e,
                              style: context.textTheme.bodyText2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: selecteds[i]
                                    ? context.colorScheme.onPrimary
                                    : context.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
