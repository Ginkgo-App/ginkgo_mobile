part of '../screens.dart';

class PlaceDetailScreenArgs {
  final Place place;

  PlaceDetailScreenArgs(this.place) : assert(place != null);
}

class PlaceDetailScreen extends StatefulWidget {
  final PlaceDetailScreenArgs args;

  const PlaceDetailScreen({Key key, this.args})
      : assert(args != null),
        super(key: key);

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final PlaceDetailBloc _placeDetailBloc = PlaceDetailBloc();
  PlaceDetailScreenArgs _args;

  @override
  void initState() {
    super.initState();
    _args = widget.args;
    _fetchData();
  }

  _fetchData() {
    _placeDetailBloc.add(PlaceDetailEventFetch(_args.place?.id));
  }

  dispose() {
    _placeDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Thông tin điểm đến'),
      body: _args?.place != null
          ? BlocBuilder(
              bloc: _placeDetailBloc,
              builder: (context, state) {
                if (state is PlaceDetailStateFailure) {
                  return ErrorIndicator(
                    moreErrorDetail: state.error.toString(),
                    onReload: _fetchData,
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      buildTopImage(),
                      if (state is PlaceDetailStateSuccess &&
                          _placeDetailBloc.place.children.length == 0)
                        NotFoundWidget(
                          message:
                              'Không có địa điểm du lịch.\nHãy liên hệ BQT để cung cấp thông tin.',
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SpacingColumn(
                            spacing: 10,
                            isSpacingHeadTale: true,
                            children: (state is PlaceDetailStateSuccess
                                    ? _placeDetailBloc.place.childrenMap()
                                    : {
                                        KeyValue(key: '', value: 'Đang tải...'):
                                            null
                                      })
                                .map(
                                  (key, value) => MapEntry(
                                    key,
                                    buildChildPlaceList(
                                        key.value, _args.place.children,
                                        isLoading:
                                            state is PlaceDetailStateLoading),
                                  ),
                                )
                                .values
                                .toList(),
                          ),
                        )
                    ],
                  ),
                );
              },
            )
          : const SizedBox.shrink(),
    );
  }

  buildTopImage() {
    return GestureDetector(
      onTap: () {
        PhotoViewDialog(context,
                images: _args?.place?.images ?? [],
                descriptions: _args?.place?.images != null
                    ? List.generate(
                        _args?.place?.images?.length,
                        (index) => PhotoViewDescription(
                              title: _args?.place?.name,
                              subTitle: _args?.place?.address,
                              content: _args?.place?.description,
                            ))
                    : null)
            .show();
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            ImageWidget(
              _args?.place?.images != null && _args.place.images.length > 0
                  ? _args.place.images[0].largeThumb
                  : '',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 200 / 375,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.black.withOpacity(0.8),
                child: RichText(
                  maxLines: 1,
                  text: TextSpan(
                      style: context.textTheme.subtitle1.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: _args.place.name ?? ''),
                        if (_args.place?.createBy?.displayName != null)
                          TextSpan(
                            text:
                                ' - Thông tin cung cấp bởi ${_args.place?.createBy?.displayName}',
                            style: TextStyle(fontSize: 14),
                          )
                        else if (_args.place?.description != null)
                          TextSpan(
                              text: ' - ${_args.place?.description}',
                              style: TextStyle(fontSize: 14))
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChildPlaceList(String title, List<Place> data,
      {bool isLoading = false}) {
    return CollapseContainer(
      title: title ?? '',
      collapseHeight: 405,
      headerUnderline: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: PlaceList(isLoading: isLoading, places: data),
      ),
    );
  }
}
