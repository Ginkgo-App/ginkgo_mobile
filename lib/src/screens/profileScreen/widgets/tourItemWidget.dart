import 'package:base/base.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/tour.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:intl/intl.dart';

class TourItemWidget extends StatelessWidget {
  final SimpleTour tour;

  const TourItemWidget({Key key, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: DesignColor.darkerWhite)),
      width: 300,
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
                  images: tour?.images ?? [],
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
                    margin: EdgeInsets.only(right: tour != null ? null : 20),
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
                      children: <Widget>[
                        _buildRowIcon(context,
                            icon: Assets.icons.planner,
                            text: tour?.host?.name ?? ''),
                        _buildRowIcon(context,
                            icon: Assets.icons.calendar,
                            // TODO calculate day difference
                            text: tour != null
                                ? '(${DateFormat('dd/MM/yyyy').format(tour.startDay)} - ${DateFormat('dd/MM/yyyy').format(tour.endDay)})'
                                : ''),
                        _buildRowIcon(context,
                            icon: Assets.icons.people,
                            text: tour != null
                                ? '${tour.totalMember} người'
                                : ''),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildRowIcon(BuildContext context, {String icon, String text}) {
    return Container(
      color: context.colorScheme.background,
      margin: EdgeInsets.only(right: text.isExistAndNotEmpty ? null : 40, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (text.isExistAndNotEmpty) ...[
            SvgPicture.asset(
              icon,
              height: 12,
            ),
            const SizedBox(width: 5),
          ],
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
