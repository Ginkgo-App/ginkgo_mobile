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
    double spacing = 0,
    bool isSpacingHeadTale = false,
    Widget separator,
  }) : super(
          children: [
            if (isSpacingHeadTale) SizedBox(height: spacing),
            ...children.addBetweenEvery(
              Column(
                children: <Widget>[
                  SizedBox(height: spacing / 2),
                  separator ?? const SizedBox.shrink(),
                  SizedBox(height: spacing / 2),
                ],
              ),
            ),
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
