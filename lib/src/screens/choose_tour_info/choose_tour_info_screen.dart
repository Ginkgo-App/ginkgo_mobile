part of '../screens.dart';

const _PAGE_SIZE = 10;

class ChooseTourInfoScreen extends StatefulWidget {
  @override
  _ChooseTourInfoScreenState createState() => _ChooseTourInfoScreenState();
}

class _ChooseTourInfoScreenState extends State<ChooseTourInfoScreen> {
  final TourInfoListBloc tourInfoListBloc = TourInfoListBloc(_PAGE_SIZE);

  initState() {
    super.initState();

    fetchData();
  }

  fetchData() {
    tourInfoListBloc
        .add(TourInfoListEventFetch());
  }

  dispose() {
    tourInfoListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Chọn mẫu'),
      body: SingleChildScrollView(
        child: BorderContainer(
          title: 'Chọn khuôn mẫu cho chuyến đi của bạn',
          childPadding: EdgeInsets.only(bottom: 10),
          margin: const EdgeInsets.all(10),
          child: BlocBuilder(
            bloc: tourInfoListBloc,
            builder: (context, state) {
              if (state is TourInfoListStateFailure) {
                return ErrorIndicator(
                  message: Strings.error.errorClick,
                  moreErrorDetail: state.error.toString(),
                  onReload: fetchData,
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: IntrinsicHeight(
                  child: SpacingColumn(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...(state is TourInfoListStateSuccess
                              ? state.tourInfoList.data
                              : List.generate(5, (_) => null))
                          .map(
                            (e) => BlackOpacityTour(
                              tourInfo: e,
                              onPressed: () {
                                if (e != null) {
                                  Navigator.pop(context, e);
                                }
                              },
                            ),
                          )
                          .toList(),
                      const SizedBox.shrink(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
