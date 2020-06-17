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

  initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    _tourDetailBloc.add(TourDetailEventFetch(widget.args.simpleTour.id));
    _tourMembersBloc.add(
      TourMembersEventFetch(
          tourId: widget.args.simpleTour.id, type: TourMembersType.accepted),
    );
  }

  _onJoinTour() {}

  dispose() {
    _tourDetailBloc.close();
    _tourMembersBloc.close();
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
                      images:
                          _tourDetailBloc.tour?.images ?? simpleTour.images),
                ),
                if (state is TourDetailStateFailure)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ErrorIndicator(
                      message: Strings.error.errorClick,
                      moreErrorDetail: state.error.toString(),
                      onReload: fetchData,
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
                            timelines:
                                List.generate(11, (_) => FakeData.timeline),
                          ),
                        ReviewList(),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: SpacingRow(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            isSpacingHeadTale: true,
            children: [
              ...[
                FakeData.simpleUser3,
                FakeData.simpleUser,
                FakeData.simpleUser2,
                FakeData.simpleUser4,
              ].map((e) => CircleUser(user: e)).toList(),
              ViewMoreButton(
                onPressed: () {},
                width: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
