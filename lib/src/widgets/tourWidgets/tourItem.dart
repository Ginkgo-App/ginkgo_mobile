import 'dart:math';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/tourWidgets/widgets/tourInfoWidget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

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
      onTap: onPressed ??
          () {
            Navigators.appNavigator.currentState.pushNamed(Routes.tourDetail);
          },
      child: Container(
        width: 240,
        height: 300,
        child: Skeleton(
          enabled: tour == null,
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
                  child: TourInfoWidget(
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: context.colorScheme.primary)),
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
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
