import 'dart:math';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/rating.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:ginkgo_mobile/src/helper/dateTimeExt.dart';
import 'package:ginkgo_mobile/src/helper/numberExt.dart';

class TourItem extends StatelessWidget {
  final SimpleTour tour;
  final bool showFriend;

  const TourItem({Key key, @required this.tour, this.showFriend = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 300,
      child: Skeleton(
        enabled: tour == null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                color: context.colorScheme.background,
                child: GalleryItem(
                  images: [
                    if (tour?.images != null && tour.images.length > 0)
                      tour.images[Random().nextInt(tour.images.length)]
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: context.colorScheme.background,
                    margin: EdgeInsets.only(right: (tour != null ? 0 : 20)),
                    child: Text(
                      tour?.name ?? '',
                      style: context.textTheme.body2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildRowIcon(context,
                            icon: Assets.icons.planner,
                            text: tour?.host != null ? tour.host.name : ''),
                        _buildRowIcon(context,
                            icon: Assets.icons.calendar,
                            text: tour != null &&
                                    tour.startDay != null &&
                                    tour.endDay != null
                                ? '${tour.startDay.toDifferentDayNight(tour.endDay)} (${tour.startDay.toVietnameseFormat()} - ${tour.endDay.toVietnameseFormat()})'
                                : ''),
                        _buildRowIcon(context,
                            icon: Assets.icons.people,
                            text: tour != null
                                ? ' ${tour.totalMember} người'
                                : '',
                            richText: tour.friend != null && showFriend
                                ? _buildRichTextFriend(
                                    context, tour.friend, tour.totalMember)
                                : null),
                        _buildRowIcon(context,
                            icon: Assets.icons.moneyBlack,
                            richText: RichText(
                              text: TextSpan(
                                  style: context.textTheme.caption,
                                  children: [
                                    TextSpan(
                                        text: '${tour.price.toShortMoney()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: '/người')
                                  ]),
                            )),
                        SizedBox(height: 5),
                        Rating(rating: tour.rating),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: context.colorScheme.primary)),
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                onPressed: () {},
                child: Text('Tham gia ngay'),
              ),
            )
          ],
        ),
      ),
    );
  }

  RichText _buildRichTextFriend(
      BuildContext context, SimpleUser friend, int totalMember) {
    return RichText(
      text: TextSpan(
        style: context.textTheme.caption,
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
            ),
            const SizedBox(width: 5),
          ],
          Expanded(
            child: richText ??
                Text(
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
