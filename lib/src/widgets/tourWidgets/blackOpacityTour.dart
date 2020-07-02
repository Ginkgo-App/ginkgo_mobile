part of '../widgets.dart';

class BlackOpacityTour extends StatelessWidget {
  final SimpleTour tour;
  final TourInfo tourInfo;
  final Function onPressed;

  const BlackOpacityTour({Key key, this.tour, this.tourInfo, this.onPressed})
      : assert(tourInfo == null || tour == null),
        super(key: key);

  _onPressed() {
    if (tour != null) {
      if (onPressed != null) return onPressed();
      Navigators.appNavigator.currentState
          .pushNamed(Routes.tourDetail, arguments: TourDetailScreenArgs(tour));
    } else if (tourInfo != null) {
      if (onPressed != null) return onPressed();
      Navigators.appNavigator.currentState.pushNamed(
        Routes.tourInfoDetail,
        arguments: TourInfoDetailScreenArgs(tourInfo: tourInfo),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final images =
        tour?.images ?? tour?.tourInfo?.images ?? tourInfo?.images ?? [];
    final image = images.length > 0 ? images[0] : null;

    return GestureDetector(
      onTap: _onPressed,
      child: Skeleton(
        enabled: tourInfo == null && tour == null,
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.background,
            boxShadow: DesignColor.imageShadow,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 320,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: AspectRatio(
              aspectRatio: 8 / 5,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: image?.mediumThumb ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, _) {
                          return Image.asset(
                            Assets.images.defaultImage,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.black.withOpacity(0.7),
                      child: tour != null
                          ? TourDetailWidget(
                              tour: tour,
                              showFriend: false,
                              showHost: false,
                              showDayNight: true,
                              showTotalMember: true,
                              showPrice: true,
                              showRating: true,
                              textColor: Colors.white,
                            )
                          : tourInfo != null
                              ? TourInfoDetailWidget(
                                  tourInfo: tourInfo,
                                  textColor: Colors.white,
                                )
                              : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
