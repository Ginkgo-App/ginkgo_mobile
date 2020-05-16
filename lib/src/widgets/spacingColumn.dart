import 'package:flutter/material.dart';
import 'package:base/base.dart';

class SpacingColumn extends Flex {
  SpacingColumn({
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
  }) : super(
          children: [
            if (isSpacingHeadTale) SizedBox(height: spacing),
            ...children.addBetweenEvery(SizedBox(height: spacing)),
            if (isSpacingHeadTale) SizedBox(height: spacing),
          ],
          key: key,
          direction: Axis.vertical,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}
