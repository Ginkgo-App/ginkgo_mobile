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
          ? Column(
              children: <Widget>[
                Container(
                  height: 200,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: ImageWidget(
                          args.place.images.length > 0
                              ? args.place.images[0]
                              : '',
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.black.withOpacity(0.8),
                          child: Text(
                            (args.place.name ?? '') +
                                (args.place.createBy != null
                                    ? ' - Thông tin cung cấp bởi ${args.place.createBy.displayName}'
                                    : ''),
                            maxLines: 1,
                            style: context.textTheme.subtitle1.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
