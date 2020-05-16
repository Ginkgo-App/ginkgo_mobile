import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';

class Rating extends StatelessWidget {
  final int rating;

  const Rating({Key key,@required this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 2,
      runSpacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        ...List.generate(
          5,
          (i) => Container(
            width: 25,
            height: 3,
            color:
                rating >= i + 1 ? DesignColor.lightRed : DesignColor.lightLightPink,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$rating/5 điểm',
          style: context.textTheme.overline.copyWith(
            color: DesignColor.darkRed,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
  
}