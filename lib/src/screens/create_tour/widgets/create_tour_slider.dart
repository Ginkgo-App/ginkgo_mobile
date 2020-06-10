import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/widgets/customs/simple_slider.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';

class CreateTourSlider extends StatelessWidget {
  final TourInfo tourInfo;
  final double height;

  const CreateTourSlider({
    Key key,
    this.tourInfo, this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageSliderWidget(
          imageUrls: tourInfo.images.map((e) => e.mediumThumb).toList(),
          imageBorderRadius: BorderRadius.circular(0),
          padding: EdgeInsets.zero,
          showDot: false,
          showButton: true,
          imageHeight: height,
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            height: 50,
            color: Colors.black.withOpacity(0.7),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SpacingColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 5,
              isSpacingHeadTale: true,
              children: <Widget>[
                Text(
                  tourInfo?.name ?? '',
                  style: context.textTheme.body1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  (tourInfo?.startPlace?.name ?? '') +
                      ' - ' +
                      (tourInfo?.destinatePlace?.name ?? ''),
                  style:
                      context.textTheme.caption.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
