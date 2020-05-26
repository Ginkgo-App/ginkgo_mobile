import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/widgets/tourInfoWidget.dart';

class TripItem extends StatelessWidget {
  final SimpleTour tour;

  const TripItem({Key key, @required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        boxShadow: DesignColor.imageShadow,
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
                    imageUrl: tour.images.length > 0
                        ? tour.images[0].mediumThumb
                        : '',
                    fit: BoxFit.fill,
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
                  child: TourInfoWidget(
                    tour: FakeData.simpleTour,
                    showFriend: false,
                    showHost: false,
                    showDayNight: true,
                    showTotalMember: true,
                    showPrice: true,
                    showRating: true,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
