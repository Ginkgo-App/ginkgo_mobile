import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/helper/dateTimeExt.dart';
import 'package:ginkgo_mobile/src/helper/numberExt.dart';
import '../../rating.dart';

class TourInfoWidget extends StatelessWidget {
  final SimpleTour tour;
  final bool showFriend;
  final bool showHost;
  final bool showDayNight;
  final bool showTotalMember;
  final bool showPrice;
  final bool showRating;
  final Color textColor;
  final EdgeInsets rowPadding;

  const TourInfoWidget({
    Key key,
    @required this.tour,
    this.showFriend = false,
    this.showHost = false,
    this.showDayNight = false,
    this.showTotalMember = false,
    this.showPrice = false,
    this.showRating = false,
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
            tour?.name ?? '',
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
              if (showHost)
                _buildRowIcon(context,
                    icon: Assets.icons.planner, text: tour?.host?.displayName),
              if (showDayNight)
                _buildRowIcon(context,
                    icon: Assets.icons.calendar,
                    text: tour != null &&
                            tour.startDay != null &&
                            tour.endDay != null
                        ? '${tour.startDay.toDifferentDayNight(tour.endDay)} (${tour.startDay.toVietnameseFormat()} - ${tour.endDay.toVietnameseFormat()})'
                        : ''),
              if (showTotalMember)
                _buildRowIcon(context,
                    icon: Assets.icons.people,
                    text: tour != null ? '${tour.totalMember} người' : '',
                    richText: showFriend && tour.friends != null && tour.friends.length > 0
                        ? _buildRichTextFriend(
                            context, tour.friends[0], tour.totalMember)
                        : null),
              if (showPrice)
                _buildRowIcon(context,
                    icon: Assets.icons.moneyBlack,
                    richText: RichText(
                      text: TextSpan(
                          style: context.textTheme.caption
                              .copyWith(color: textColor),
                          children: [
                            TextSpan(
                                text: '${tour.price.toShortMoney()}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '/người')
                          ]),
                    )),
              SizedBox(height: 5),
              if (showRating) Rating(rating: tour.rating),
              SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  RichText _buildRichTextFriend(
      BuildContext context, SimpleUser friend, int totalMember) {
    return RichText(
      text: TextSpan(
        style: context.textTheme.caption.copyWith(color: textColor),
        children: [
          TextSpan(text: 'Có '),
          TextSpan(
            text: friend.displayName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' và '),
          TextSpan(
            text: '$totalMember người khác',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
