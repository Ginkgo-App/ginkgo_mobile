part of '../widgets.dart';

class TourItem extends StatelessWidget {
  final SimpleTour tour;
  final bool showFriend;
  final Function(SimpleTour tour) onPressed;

  const TourItem(
      {Key key, @required this.tour, this.showFriend = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tour != null) {
          onPressed?.call(tour) ??
              Navigators.appNavigator.currentState.pushNamed(Routes.tourDetail,
                  arguments: TourDetailScreenArgs(tour));
        }
      },
      child: Container(
        width: 240,
        height: 350,
        child: Skeleton(
          enabled: tour == null,
          autoContainer: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: context.colorScheme.background,
                  child: GalleryItem(
                    images: [
                      if (tour?.images != null && tour.images.length > 0)
                        tour.images[Random().nextInt(tour.images.length)]
                            .mediumThumb
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TourDetailWidget(
                    tour: tour,
                    textColor: context.colorScheme.onBackground,
                    showHost: true,
                    showFriend: showFriend,
                    showDayNight: true,
                    showTotalMember: true,
                    showPrice: true,
                    showRating: true,
                    rowPadding: const EdgeInsets.only(left: 20),
                  )),
              if (tour != null)
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: context.colorScheme.primary)),
                  child: CupertinoButton(
                    minSize: 0,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    onPressed: () {},
                    child: Text('Tham gia ngay'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
