

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';

import 'create_tour_slider.dart';

class SliverCreateTourAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 175;
  final double minHeight = 50;
  final TourInfo tourInfo;
  final PreferredSizeWidget bottom;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  SliverCreateTourAppBarDelegate(
    this.tourInfo, {
    this.snapConfiguration,
    this.bottom,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));
    final height = maxExtent - (maxExtent - minExtent) * scrollRate;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            DesignColor.lighterPink,
            Color(0xfffff2ee),
            Color(0xfffff2ee).withOpacity(0),
          ],
          stops: [0, 0.95, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height:
                  expandedHeight - (expandedHeight - minHeight) * scrollRate,
              child: CreateTourSlider(
                tourInfo: tourInfo,
                height: height,
              ),
            ),
            if (bottom != null) bottom
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  double get minExtent => minHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}