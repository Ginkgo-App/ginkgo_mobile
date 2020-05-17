import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';

class ViewMoreButton extends StatelessWidget {
  final Function onPressed;
  final double width;

  const ViewMoreButton({Key key, @required this.onPressed, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.all(0),
            child: SvgPicture.asset(
              Assets.icons.readmore,
              color: DesignColor.lighterRed,
              width: 40,
              height: 40,
              fit: BoxFit.fill,
            ),
            onPressed: () {},
          ),
          Text(
            'Xem tất cả',
            style: TextStyle(
                color: DesignColor.lighterRed, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
