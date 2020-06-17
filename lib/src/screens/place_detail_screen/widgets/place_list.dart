library place_detail_widgets;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places;

  const PlaceList({Key key, @required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const RATIO = 16 / 13;
    final itemWidth = (MediaQuery.of(context).size.width - 45) / 2;
    final itemHeight = itemWidth / RATIO;

    return places.length > 0
        ? IntrinsicHeight(
            child: SpacingRow(
              reverse: Random().nextInt(1) == 0,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: places
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                            i,
                            i.isEven
                                ? buildPlaceImage(context, e, itemHeight)
                                : buildPlaceDetail(context, e, itemHeight),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(height: itemHeight / 4),
                    ...places
                        .asMap()
                        .map(
                          (i, e) => MapEntry(
                            i,
                            i.isOdd
                                ? buildPlaceImage(context, e, itemHeight)
                                : buildPlaceDetail(context, e, itemHeight),
                          ),
                        )
                        .values
                        .toList()
                  ],
                )),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  Widget buildPlaceImage(BuildContext context, Place place, double height) {
    return Stack(
      children: <Widget>[
        ImageWidget(
          place.images.length > 0 ? place.images[0].largeThumb : '',
          height: height,
        ),
        Positioned(
          left: 5,
          top: 5,
          child: CupertinoButton(
            onPressed: () {},
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                Strings.button.viewAll,
                style: context.textTheme.overline.copyWith(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPlaceDetail(BuildContext context, Place place, double height) {
    return Container(
      height: height / 2,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            place?.name ?? '',
            style: context.textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            place?.address ?? '',
            style: context.textTheme.caption
                .copyWith(color: DesignColor.tinyItems),
          ),
        ],
      ),
    );
  }
}
