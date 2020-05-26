import 'package:flutter/material.dart';
import 'package:base/base.dart';

class SpacingRow extends Flex {
  SpacingRow({
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
    double spacing,
    bool isSpacingHeadTale = false,
    bool reverse = false,
  }) : super(
          children: [
            if (isSpacingHeadTale) SizedBox(width: spacing),
            ...(reverse
                ? children.addBetweenEvery(SizedBox(width: spacing)).reversed
                : children.addBetweenEvery(SizedBox(width: spacing))),
            if (isSpacingHeadTale) SizedBox(width: spacing),
          ],
          key: key,
          direction: Axis.horizontal,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}
