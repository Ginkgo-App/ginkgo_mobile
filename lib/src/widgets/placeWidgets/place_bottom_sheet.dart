part of '../widgets.dart';

const _SEARCH_BLOCK_DURATION = 1000;

Future<Place> showPlaceBottomSheet(BuildContext context,
    {Place selectedPlace}) async {
  final currentPlace = selectedPlace;
  final PlaceListBloc placeListBloc = PlaceListBloc();

  await showSlidingBottomSheet(
    context,
    builder: (context) {
      return SlidingSheetDialog(
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          cornerRadius: 10,
          headerBuilder: (context, _) {
            return _buildHeader(context, placeListBloc);
          },
          builder: (context, _) {
            return Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(20, (_) => FakeData.place)
                    .map<Widget>(
                      (e) => FlatButton(
                        child: SpacingRow(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(e.name?.toString() ?? '',
                                style: context.textTheme.body1),
                            Icon(
                              Icons.check_circle,
                              color: DesignColor.darkestGreen,
                              size: 18,
                            ),
                          ],
                        ),
                        color: context.colorScheme.background,
                        highlightColor: DesignColor.darkestWhite,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
          });
    },
  );

  placeListBloc.close();
  return currentPlace;
}

_buildHeader(BuildContext context, PlaceListBloc placeListBloc) {
  Timer blockTimer;

  return Material(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder(
        bloc: placeListBloc,
        builder: (context, state) {
          return TextField(
            autofocus: true,
            onChanged: (v) {
              Debouncer(delay: new Duration(milliseconds: 500)).debounce(() {
                placeListBloc.add(
                  PlaceListEventFetch(v, 'all', 1, 0),
                );
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: GradientOutlineInputBorder(
                focusedGradient: GradientColor.of(context).primaryGradient,
                borderRadius: BorderRadius.circular(90),
                gapPadding: 0,
              ),
              hintText: 'Tìm kiếm địa điểm',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Assets.icons.address,
                  height: 20,
                ),
              ),
              suffix: SizedBox(
                height: 20,
                width: 20,
                child: Center(
                  child: state is! PlaceListStateLoading
                      ? Icon(Icons.search)
                      : LoadingIndicator(
                          size: 20,
                          color: context.colorScheme.primary,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class Debouncer {
  Duration delay;
  Timer _timer;
  VoidCallback _callback;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void debounce(VoidCallback callback) {
    this._callback = callback;

    this.cancel();
    _timer = new Timer(delay, this.flush);
  }

  void cancel() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void flush() {
    this._callback();
    this.cancel();
  }
}
