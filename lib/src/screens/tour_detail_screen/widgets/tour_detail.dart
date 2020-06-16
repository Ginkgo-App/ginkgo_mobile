import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ginkgo_mobile/src/helper/dateTimeExt.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class TourDetail extends StatelessWidget {
  final bool isLoading;
  final String tourName;
  final Tour tour;

  const TourDetail(
      {Key key,
      @required this.tour,
      this.isLoading = false,
      @required this.tourName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: tourName ?? tour?.name,
      child: Skeleton(
        enabled: isLoading,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SpacingColumn(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Rating(rating: tour.rating),
              if (isLoading || tour?.createBy != null)
                _buildRowIcon(context,
                    icon: Assets.icons.planner,
                    text: tour.createBy.displayName),
              if (isLoading || tour?.startDay != null && tour?.endDay != null)
                _buildRowIcon(context,
                    icon: Assets.icons.calendar,
                    text:
                        '${TotalDayNight(totalDay: tour?.totalDay, totalNight: tour?.totalNight)} (${tour?.startDay?.toVietnameseFormat()} - ${tour?.endDay?.toVietnameseFormat()})'),
              if (isLoading || tour?.tourInfo?.startPlace != null)
                _buildRowIcon(
                  context,
                  icon: Assets.icons.startPlace,
                  richText: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Điểm bắt đầu tại ',
                      style: context.textTheme.bodyText2
                          .copyWith(color: context.colorScheme.onBackground),
                      children: <TextSpan>[
                        TextSpan(
                            text: tour?.tourInfo?.startPlace?.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              if (isLoading || tour?.tourInfo?.destinatePlace != null)
                _buildRowIcon(
                  context,
                  icon: Assets.icons.endPlace,
                  richText: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'Điểm kết thúc tại ',
                      style: context.textTheme.bodyText2
                          .copyWith(color: context.colorScheme.onBackground),
                      children: <TextSpan>[
                        TextSpan(
                            text: tour?.tourInfo?.destinatePlace?.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              if (isLoading || tour?.totalMember != null)
                _buildRowIcon(context,
                    icon: Assets.icons.planner,
                    text: '${tour?.totalMember?.toString() ?? ''} người'),
              if (isLoading || tour?.price != null)
                _buildRowIcon(
                  context,
                  icon: Assets.icons.planner,
                  richText: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: '${tour?.price}đ/',
                      style: context.textTheme.bodyText2.copyWith(
                          color: context.colorScheme.onBackground,
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Người',
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRowIcon(BuildContext context,
      {String icon, String text, RichText richText}) {
    return Container(
      color: context.colorScheme.background,
      margin: EdgeInsets.only(right: text.isExistAndNotEmpty ? 0 : 40, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (text.isExistAndNotEmpty) ...[
            SvgPicture.asset(
              icon,
              height: 14,
              color: context.colorScheme.onBackground,
            ),
            const SizedBox(width: 5),
          ],
          Expanded(
            child: richText == null
                ? Text(
                    text ?? '',
                    style: context.textTheme.bodyText2.copyWith(
                      color: context.colorScheme.onBackground,
                    ),
                  )
                : richText,
          )
        ],
      ),
    );
  }
}
