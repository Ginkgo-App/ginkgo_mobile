part of '../screens.dart';

class PlaceDetailScreenArgs {
  final Place place;

  PlaceDetailScreenArgs(this.place);
}

class PlaceDetailScreen extends StatefulWidget {
  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  PlaceDetailScreenArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context).settings.arguments;

      if (args == null || args.place == null) {
        debugPrint('Place null');
        Navigator.of(context).pop();
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      appBar: BackAppBar(title: 'Thông tin điểm đến'),
      body: args?.place != null
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildTopImage(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SpacingColumn(
                      spacing: 10,
                      isSpacingHeadTale: true,
                      children: <Widget>[
                        buildChildPlaceList(args.place.children)
                      ],
                    ),
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  buildTopImage() {
    return Container(
      child: Stack(
        children: <Widget>[
          ImageWidget(
            args.place.images.length > 0 ? args.place.images[0] : '',
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
                text: TextSpan(
                    style: context.textTheme.subtitle1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: args.place.name ?? ''),
                      if (args?.place?.name != null)
                        TextSpan(
                            text:
                                ' - Thông tin cung cấp bởi ${args.place.createBy.displayName}',
                            style: TextStyle(fontSize: 14)),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildChildPlaceList(List<Place> data) {
    return CollapseContainer(
      title: 'type.value',
      collapseHeight: 405,
      headerUnderline: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: PlaceList(places: args.place.children),
      ),
    );
  }
}
