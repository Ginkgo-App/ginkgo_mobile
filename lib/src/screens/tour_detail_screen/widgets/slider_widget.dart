import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/customs/simple_slider.dart';

class SliderWidget extends StatelessWidget {
  final List<MultiSizeImage> images;
  final Function(List<MultiSizeImage>) onViewAll;

  const SliderWidget({Key key, @required this.images, this.onViewAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageSliderWidget(
          imageUrls: images.map((e) => e.mediumThumb).toList(),
          imageBorderRadius: BorderRadius.circular(0),
          padding: EdgeInsets.zero,
        ),
        Positioned(
          top: 10,
          left: 10,
          child: CupertinoButton(
            onPressed: onViewAll ??
                () {
                  // TODO Implement view list image.
                },
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            minSize: 0,
            borderRadius: BorderRadius.circular(5),
            color: Colors.black.withOpacity(0.7),
            child: Text(
              Strings.button.viewAllImages,
              style: context.textTheme.caption
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
