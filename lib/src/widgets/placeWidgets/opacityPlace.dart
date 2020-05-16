import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/place.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';

class OpacityPlace extends StatelessWidget {
  final Place place;

  const OpacityPlace({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 60) / 3;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: AspectRatio(
        aspectRatio: 5 / 6,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: context.colorScheme.background,
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: place.images.length > 0 ? place.images[0] : '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                        style: context.textTheme.caption.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        Strings.place.tourCount(place.tourCount),
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
    );
  }
}
