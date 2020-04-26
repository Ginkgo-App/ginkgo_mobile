import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/utils/imageFiles.dart';

class TourItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: DesignColor.darkerWhite)),
      width: 300,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl:
                    'https://yt3.ggpht.com/a/AGF-l78QGTW3gMAN3s_devNGhlzjBO9eCRPGTg0iUQ=s900-c-k-c0xffffffff-no-rj-mo',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Tour du lịch Hội An - Đà Nẵng',
                  style: context.textTheme.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      _buildRowIcon(context,
                          icon: ImageFiles.icon.planner,
                          text: 'Saigon Tourist'),
                      _buildRowIcon(context,
                          icon: ImageFiles.icon.calendar,
                          text: '3 ngày 2 đêm (20/04/2020 - 22/04/2020)'),
                      _buildRowIcon(context,
                          icon: ImageFiles.icon.people, text: '15 người'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildRowIcon(BuildContext context, {String icon, String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            icon,
            height: 12,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.caption.copyWith(
                color: context.colorScheme.onBackground,
              ),
            ),
          )
        ],
      ),
    );
  }
}
