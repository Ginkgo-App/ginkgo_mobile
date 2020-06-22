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
  final TourMembersBloc _tourMembersBloc = TourMembersBloc(10);
  final TourReviewsBloc _tourReviewsBloc = TourReviewsBloc(10);

  initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() {
    _tourDetailBloc.add(TourDetailEventFetch(widget.args.simpleTour.id));
    _fetchFriend();
    _fetchReview();
  }

  _fetchFriend() {
    _tourMembersBloc.add(
      TourMembersEventFetch(
          tourId: widget.args.simpleTour.id, type: TourMembersType.accepted),
    );
  }

  _fetchReview() {
    _tourReviewsBloc
        .add(TourReviewsEventFetch(tourId: widget.args.simpleTour.id));
  }

  _onJoinTour() {}

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
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            child: state is TourDetailStateSuccess &&
                    _tourDetailBloc.tour.canJoin(currentUser)
                ? PrimaryButton(
                    title: Strings.button.takePartInNow,
                    width: double.maxFinite,
                    onPressed: _onJoinTour,
                  )
                : null,
          ),
          body: SingleChildScrollView(
            child: Column(
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
                          ServiceList(),
                        buildMembers(),
                        if (state is! TourDetailStateSuccess ||
                            _tourDetailBloc.tour?.timelines != null)
                          TimelineWidget(
                            isLoading: state is TourDetailStateLoading,
                            timelines: _tourDetailBloc.tour?.timelines,
                          ),
                        _buildReviews(),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildMembers() {
    return BorderContainer(
      title: 'Những người tham gia',
      childPadding: EdgeInsets.only(bottom: 10),
      child: BlocBuilder(
        bloc: _tourMembersBloc,
        builder: (context, state) {
          if (state is TourMembersStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error.toString(),
              onReload: _fetchFriend,
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
                  ViewMoreButton(
                    onPressed: () {
                      // TODO Navigate to tour members screen.
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
        collapseHeight: 280,
        child: BlocBuilder(
          bloc: _tourReviewsBloc,
          builder: (context, state) {
            if (state is TourReviewsStateFailure) {
              return ErrorIndicator(
                moreErrorDetail: state.error.toString(),
                onReload: _fetchReview,
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
        ));
  }
}
