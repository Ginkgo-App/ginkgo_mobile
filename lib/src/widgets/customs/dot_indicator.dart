import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 10.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 15.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
//        1.0 -  (controller.hasClients ?  ( ((controller.page ?? controller.initialPage) - index).abs()) : 0),
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: Material(
          type: MaterialType.circle,
          color: Colors.white,
          child: new Material(
            color: color.withOpacity(1 * selectedness),
            type: MaterialType.circle,
            child: new Container(
              width: _kDotSize,
              height: _kDotSize,
              child: new InkWell(
                onTap: () => onPageSelected(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
