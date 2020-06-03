import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/rating.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:ginkgo_mobile/src/helper/dateTimeExt.dart';
import 'package:base/base.dart';

class TourDetail extends StatelessWidget {
  final SimpleTour simpletour = FakeData.simpleTour;
  
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: simpletour.name,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Rating(rating: simpletour.rating),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(Assets.icons.planner)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  simpletour.host.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15, color: context.colorScheme.onBackground),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(Assets.icons.calendar),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${simpletour.startDay.toDifferentDayNight(simpletour.endDay)} (${simpletour.startDay.toVietnameseFormat()} - ${simpletour.endDay.toVietnameseFormat()})',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15, color: context.colorScheme.onBackground),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(Assets.icons.startPlace),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Điểm bắt đầu tại ',
                    style: TextStyle(
                        fontSize: 15, color: context.colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Buôn Ma Thuột',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(Assets.icons.endPlace),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Điểm kết thúc tại ',
                    style: TextStyle(
                        fontSize: 15, color: context.colorScheme.onBackground),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Núi phú sĩ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(Assets.icons.people)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  simpletour.totalMember.toString() + ' người',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15, color: context.colorScheme.onBackground),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(Assets.icons.moneyBlack)),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: '${simpletour.price}đ/',
                    style: TextStyle(
                        fontSize: 15,
                        color: context.colorScheme.onBackground,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Người',
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Container(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(Assets.icons.groupChat)),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: (){},
                  child: Text(
                    'Nhấn vào đây để tham gia group chat',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15, color: context.colorScheme.secondary),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
