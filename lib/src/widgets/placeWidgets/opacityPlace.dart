part of '../widgets.dart';

class OpacityPlace extends StatelessWidget {
  final Place place;
  final Function(Place) onPressed;

  const OpacityPlace({Key key, @required this.place, this.onPressed})
      : super(key: key);

  _onPressed() {
    if (onPressed != null) {
      onPressed(place);
    } else {
      Navigators.appNavigator.currentState.pushNamed(Routes.placeDetail,
          arguments: PlaceDetailScreenArgs(place));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 60) / 3;

    return Skeleton(
      enabled: place == null,
      child: GestureDetector(
        onTap: _onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: AspectRatio(
            aspectRatio: 5 / 6,
            child: Container(
              width: width,
              color: context.colorScheme.background,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl:
                            place?.images != null && place.images.length > 0
                                ? place.images[0].mediumThumb
                                : '',
                        fit: BoxFit.cover,
                        placeholder: (context, _) => Constains.defaultImage,
                      ),
                    ),
                  ),
                  if (place != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.black.withOpacity(0.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              place?.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.caption.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Strings.place.tourCount(place?.tourCount ?? 0),
                              maxLines: 1,
                              style: context.textTheme.caption
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
