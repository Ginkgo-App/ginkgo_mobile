part of '../screens.dart';

class TourDetailScreenArgs {
  final SimpleTour simpleTour;

  TourDetailScreenArgs(this.simpleTour) : assert(simpleTour != null);
}

class TourDetailScreen extends StatefulWidget {
  final TourDetailScreenArgs args;

  const TourDetailScreen({Key key, @required this.args})
      : assert(args != null),
        super(key: key);

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  final TourDetailBloc _tourDetailBloc = TourDetailBloc();
  TourMembersBloc _tourMembersBloc;
  final TourReviewsBloc _tourReviewsBloc = TourReviewsBloc(10);

  initState() {
    super.initState();
    _tourMembersBloc =
        TourMembersBloc(10, widget.args.simpleTour.id, TourMemberType.accepted);
    _fetchData();
  }

  _fetchData() {
    _tourDetailBloc.add(TourDetailEventFetch(widget.args.simpleTour.id));
    _tourDetailBloc.waitOne([TourDetailStateSuccess]).then((value) {
      _fetchMembers();
      _tourMembersBloc.waitOne([TourMembersStateSuccess]).then((value) {
        _fetchReview();
      });
    });
  }

  _fetchMembers() {
    _tourMembersBloc.add(TourMembersEventFetch());
  }

  _fetchReview() {
    _tourReviewsBloc
        .add(TourReviewsEventFetch(tourId: widget.args.simpleTour.id));
  }

  _onJoinTour() {
    JoinTourBloc().add(JoinTourEventJoin(widget.args.simpleTour.id));
    JoinTourBloc().waitOne([JoinTourStateSuccess],
        throwStates: [JoinTourStateFailure]).then((value) {
      showErrorMessage('Tham gia thành công.\nVui lòng đợi duyệt');
      _fetchData();
      _fetchMembers();
    });
  }

  _onReview(Tour tour) {
    Navigators.appNavigator.currentState.pushNamed(Routes.createPost,
        arguments: CreatePostScreenArgs(tour: tour));
  }

  @override
  dispose() {
    _tourDetailBloc.close();
    _tourMembersBloc.close();
    _tourReviewsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final simpleTour = widget.args.simpleTour;
    final currentUser = CurrentUserBloc().currentUser.toSimpleUser();

    return BlocBuilder<TourDetailBloc, TourDetailState>(
      bloc: _tourDetailBloc,
      builder: (context, state) {
        return PrimaryScaffold(
          appBar: BackAppBar(
            title: 'Chi tiết chuyến đi',
          ),
          bottomNavigationBar: state is TourDetailStateSuccess
              ? (_tourDetailBloc.tour.canJoin(currentUser)
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: BlocBuilder(
                          bloc: JoinTourBloc(),
                          builder: (context, state) {
                            if (state is JoinTourStateFailure) {
                              showErrorMessage(state.error.toString());
                            }

                            return PrimaryButton(
                              title: Strings.button.takePartInNow,
                              width: double.maxFinite,
                              isLoading: state is JoinTourStateLoading,
                              onPressed: _onJoinTour,
                            );
                          }),
                    )
                  : (_tourDetailBloc.tour.canReview(currentUser)
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: PrimaryButton(
                            title: 'Viết đánh giá',
                            width: double.maxFinite,
                            isLoading: state is JoinTourStateLoading,
                            onPressed: () => _onReview(_tourDetailBloc.tour),
                          ),
                        )
                      : null))
              : null,
          body: ListView(
            children: <Widget>[
              Hero(
                tag: HeroKeys.tourImage(simpleTour.id),
                child: SliderWidget(
                    images: _tourDetailBloc.tour?.images ??
                        simpleTour.images ??
                        []),
              ),
              if (state is TourDetailStateFailure)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ErrorIndicator(
                    moreErrorDetail: state.error.toString(),
                    onReload: _fetchData,
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SpacingColumn(
                    spacing: 10,
                    isSpacingHeadTale: true,
                    children: <Widget>[
                      TourDetail(
                        tourName: simpleTour.name,
                        tour: _tourDetailBloc.tour,
                        isLoading: state is TourDetailStateLoading,
                      ),
                      if (state is! TourDetailStateSuccess ||
                          _tourDetailBloc.tour?.services != null &&
                              _tourDetailBloc.tour.services.length > 0)
                        ServiceList(services: _tourDetailBloc.tour?.services),
                      _buildMembers(
                          _tourDetailBloc.tour?.isHost(currentUser) ?? false),
                      if (state is! TourDetailStateSuccess ||
                          _tourDetailBloc.tour?.timelines != null)
                        TimelineWidget(
                          isLoading: state is TourDetailStateLoading,
                          timelines: _tourDetailBloc.tour?.timelines,
                        ),
                      if (_tourDetailBloc.tour?.status == TourStatus.ended)
                        _buildReviews(),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  _buildMembers(bool isHost) {
    return BorderContainer(
      title: 'Những người tham gia',
      childPadding: EdgeInsets.only(bottom: 10),
      actions: <Widget>[
        CupertinoButton(
          minSize: 1,
          padding: EdgeInsets.zero,
          child: Text(
            isHost ? 'Quản lý người tham gia' : 'Tất cả thành viên',
            style: context.textTheme.caption.copyWith(
              fontWeight: FontWeight.bold,
              color: DesignColor.cta,
            ),
          ),
          onPressed: () {
            MembersBottomSheet(
              context,
              tourId: _tourDetailBloc.tour?.id ?? 0,
              isHost: isHost ?? false,
            ).show();
          },
        )
      ],
      child: BlocBuilder(
        bloc: _tourMembersBloc,
        builder: (context, state) {
          if (state is TourMembersStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error.toString(),
              onReload: _fetchMembers,
            );
          } else if (state is TourMembersStateSuccess &&
              state.members.pagination.totalElement == 0) {
            return NotFoundWidget(
              message: 'Chưa ai tham gia!',
              showImage: false,
              showBorderBox: false,
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: SpacingRow(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                isSpacingHeadTale: true,
                children: [
                  ...(state is TourMembersStateLoading
                          ? List.generate(5, (index) => null)
                          : _tourMembersBloc.memberList?.data ?? [])
                      .map((e) => CircleUser(user: e))
                      .toList(),
                  if (state is TourMembersStateSuccess &&
                      state.members.canLoadmore)
                    ViewMoreButton(
                      onPressed: () {
                        MembersBottomSheet(
                          context,
                          tourId: _tourDetailBloc.tour?.id ?? 0,
                          isHost: isHost ?? false,
                        ).show();
                      },
                      width: 100,
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildReviews() {
    return CollapseContainer(
        title: 'Nhận xét từ những người đã tham gia trước đó',
        // collapseHeight: 280,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: BlocBuilder(
            bloc: _tourReviewsBloc,
            builder: (context, state) {
              if (state is TourReviewsStateFailure) {
                return ErrorIndicator(
                  moreErrorDetail: state.error.toString(),
                  onReload: _fetchReview,
                );
              } else if (state is TourReviewsStateSuccess &&
                  state.reviews.pagination.totalElement == 0) {
                return NotFoundWidget(
                  message: 'Chưa có đánh giá!',
                  showBorderBox: false,
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: (state is TourReviewsStateSuccess
                          ? _tourReviewsBloc.reviewList.data
                          : List.generate(3, (index) => null))
                      .map((e) => ReviewItem(review: e))
                      .toList(),
                ),
              );
            },
          ),
        ));
  }
}
