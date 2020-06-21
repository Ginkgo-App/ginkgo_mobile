import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';

class TourInfoDetailWidget extends StatelessWidget {
  final TourInfo tourInfo;
  final Color textColor;
  final EdgeInsets rowPadding;

  const TourInfoDetailWidget({
    Key key,
    @required this.tourInfo,
    this.textColor,
    this.rowPadding = const EdgeInsets.symmetric(horizontal: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            tourInfo?.name ?? '',
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: rowPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildRowIcon(context,
                  icon: Assets.icons.startPlace,
                  text: 'Điểm bắt đầu tại ' + tourInfo?.startPlace?.name),
              _buildRowIcon(context,
                  icon: Assets.icons.endPlace,
                  text: 'Điểm kết thúc tại ' + tourInfo?.destinatePlace?.name),
              SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  _buildRowIcon(BuildContext context,
      {String icon, String text, RichText richText}) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(right: text.isExistAndNotEmpty ? 0 : 40, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (icon.isExistAndNotEmpty) ...[
            SvgPicture.asset(
              icon,
              height: 12,
              color: textColor,
            ),
            const SizedBox(width: 5),
          ],
          Expanded(
            child: richText ??
                Text(
                  text ?? '',
                  style: context.textTheme.caption.copyWith(
                    color: textColor,
                  ),
                ),
          )
        ],
      ),
    );
  }
}
