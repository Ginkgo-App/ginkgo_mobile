import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/widgets/gradientOutlineBorder.dart';
import 'package:ginkgo_mobile/src/widgets/logoWidget.dart';
import 'package:base/base.dart';

class HomeSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  static const _LOGO_MAX_SIZE = 130;
  static const _LOGO_MIN_SIZE = 70;
  static const _HEADER_MIN_HEIGHT = 80;
  static const _ELLIPSE_WIDTH = 742.0;
  static const _ELLIPSE_HEIGHT = 264.0;
  final double expandedHeight;
  final PreferredSizeWidget bottom;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  HomeSliverAppBarDelegate(
      {@required this.expandedHeight, this.bottom, this.snapConfiguration});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final logoMarginLeft =
        (MediaQuery.of(context).size.width - _LOGO_MAX_SIZE) / 2;
    final scrollRate =
        min(1.0, max<double>(0.0, shrinkOffset / (maxExtent - minExtent)));

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
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Positioned(
            left: -186,
            right: -186,
            top: (expandedHeight - _ELLIPSE_HEIGHT) +
                (_HEADER_MIN_HEIGHT - expandedHeight) * scrollRate,
            bottom: 0,
            child: Column(
              children: <Widget>[
                Container(
                  width: _ELLIPSE_WIDTH,
                  height: _ELLIPSE_HEIGHT,
                  decoration: BoxDecoration(
                      color: DesignColor.lightPink,
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(742, 264))),
                ),
                if (bottom != null) Expanded(child: bottom)
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 20,
            child: Opacity(
              opacity: (1 - scrollRate),
              child: IgnorePointer(child: Image.asset(Assets.images.homeLeafs)),
            ),
          ),
          Positioned(
            left: 12 + 68 * scrollRate,
            right: 12,
            top: 140 - 125 * scrollRate,
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Color(0xffE4D8D8), width: 1),
                boxShadow: DesignColor.defaultDropShadow,
                borderRadius: BorderRadius.circular(5),
                color: context.colorScheme.background,
              ),
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                    border: GradientOutlineInputBorder(
                      borderSide: BorderSide.none,
                      focusedGradient:
                          GradientColor.of(context).primaryGradient,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(Assets.icons.search),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    hintText: 'Tìm kiếm...'),
              ),
            ),
          ),
          Positioned(
            left: logoMarginLeft - ((logoMarginLeft - 5) * scrollRate),
            top: 5,
            child: LogoWidget(
              width: _LOGO_MAX_SIZE - _LOGO_MIN_SIZE * scrollRate,
              height: _LOGO_MAX_SIZE - _LOGO_MIN_SIZE * scrollRate,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + (bottom?.preferredSize?.height ?? 0);

  @override
  double get minExtent =>
      _HEADER_MIN_HEIGHT + (bottom?.preferredSize?.height ?? 0);

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
