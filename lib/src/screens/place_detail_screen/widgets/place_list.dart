library place_detail_widgets;

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/constrains.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class PlaceList extends StatelessWidget {
  final bool isLoading;
  final List<Place> places;

  const PlaceList({Key key, @required this.places, this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const RATIO = 16 / 13;
    final itemWidth = (MediaQuery.of(context).size.width - 45) / 2;
    final itemHeight = itemWidth / RATIO;

    final _places = isLoading ? List.generate(4, (index) => null) : places;

    return _places != null && _places.length > 0
        ? Skeleton(
            enabled: isLoading,
            child: IntrinsicHeight(
              child: SpacingRow(
                reverse: Random().nextInt(1) == 0,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _places
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: itemHeight / 6),
                        ..._places
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
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget buildPlaceImage(BuildContext context, Place place, double height) {
    return SkeletonItem(
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: place?.images != null && place.images.length > 0
                ? place.images[0].largeThumb
                : '',
            placeholder: (context, _) => Constains.defaultImage,
            height: height,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          if (place?.images != null && place.images.length > 0)
            Positioned(
              left: 5,
              top: 5,
              child: CupertinoButton(
                onPressed: () {
                  PhotoViewDialog(
                    context,
                    images: place?.images,
                    descriptions: List.generate(
                      place?.images?.length,
                      (index) => PhotoViewDescription(
                        title: place.name,
                        subTitle: place.address,
                        content: place.description,
                      ),
                    ),
                  ).show();
                },
                minSize: 0,
                padding: EdgeInsets.zero,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    Strings.button.viewAll,
                    style: context.textTheme.overline
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildPlaceDetail(BuildContext context, Place place, double height) {
    return Container(
      height: height / 3 * 2,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SkeletonItem(
            child: Text(
              place?.name ?? '',
              textAlign: TextAlign.left,
              style: context.textTheme.bodyText2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (isLoading) const SizedBox(height: 3),
          if (isLoading || place?.address != null || place?.description != null)
            Flexible(
              fit: FlexFit.loose,
              child: SkeletonItem(
                child: Text(
                  place?.address ?? place?.description ?? '',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: context.textTheme.caption
                      .copyWith(color: DesignColor.tinyItems),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
