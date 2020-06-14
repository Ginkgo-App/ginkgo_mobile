part of '../screens.dart';

class TourInfoDetailScreenArgs {
  final int tourInfoId;
  final TourInfo tourInfo;

  TourInfoDetailScreenArgs({this.tourInfoId, this.tourInfo})
      : assert(tourInfoId != null || tourInfo != null);
}

class TourInfoDetailScreen extends StatefulWidget {
  final TourInfoDetailScreenArgs args;

  const TourInfoDetailScreen({Key key, @required this.args})
      : assert(args != null),
        super(key: key);

  @override
  _TourInfoDetailScreenState createState() => _TourInfoDetailScreenState();
}

class _TourInfoDetailScreenState extends State<TourInfoDetailScreen>
    with LoadmoreMixin {
  final TourInfoDetailBloc tourInfoDetailBloc = TourInfoDetailBloc();

  initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    tourInfoDetailBloc.add(TourInfoDetailEventFetch(
        widget.args.tourInfoId ?? widget.args.tourInfo.id));
  }

  @override
  onLoadMore() {
    tourInfoDetailBloc.add(TourInfoDetailEventLoadMore());
  }

  dispose() {
    tourInfoDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(
        title: 'Chi tiết mẫu chuyến đi',
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: PrimaryButton(
          title: Strings.button.createTourNow,
          width: double.maxFinite,
          onPressed: () {
            Navigators.appNavigator.currentState.pushNamed(Routes.createTour,
                arguments: tourInfoDetailBloc.tourInfo ?? widget.args.tourInfo);
          },
        ),
      ),
      body: BlocBuilder(
        bloc: tourInfoDetailBloc,
        builder: (context, state) {
          if (state is TourInfoDetailStateFailure) {
            return Center(
              child: ErrorIndicator(
                message: Strings.error.errorClick,
                moreErrorDetail: state.error.toString(),
                onReload: fetchData,
              ),
            );
          }
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: <Widget>[
                SliderWidget(
                    images: tourInfoDetailBloc.tourInfo?.images ??
                        widget.args.tourInfo?.images ??
                        []),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SpacingColumn(
                    spacing: 10,
                    isSpacingHeadTale: true,
                    children: <Widget>[
                      TourInfoDetail(
                        tourInfo:
                            tourInfoDetailBloc.tourInfo ?? widget.args.tourInfo,
                      ),
                      TourListBox(
                        tourList: tourInfoDetailBloc.tourList?.data,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
