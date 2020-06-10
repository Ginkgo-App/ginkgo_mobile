import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/tour_detail_screen/widgets/timeline_detail_widget.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class TimelineWidget extends StatelessWidget {
  final List<Timeline> timelines;

  static final Color _startColor = DesignColor.lighterRed;
  static final Color _endColor = DesignColor.darkestRed;

  const TimelineWidget({Key key, @required this.timelines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return timelines == null || timelines.length == 0
        ? const SizedBox.shrink()
        : CollapseContainer(
          title: 'Lịch trình chi tiết',
          height: 245,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              children: timelines
                  .asMap()
                  .map((i, e) =>
                      MapEntry(i, buildTimelineItem(context, i, e)))
                  .values
                  .toList(),
            ),
          ),
        );
  }

  Widget buildTimelineItem(BuildContext context, int index, Timeline timeline) {
    final Color color =
        Color.lerp(_startColor, _endColor, index / timelines.length);
    int detailHasImageCount = -1; //Đếm những detail có hình để hiển thị so le

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildMilestones(context, index,
              isLast: index == timelines.length - 1, color: color),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Ngày ${index + 1} (${timeline.day.toVietNamese()})',
                    style: context.textTheme.body1
                        .copyWith(fontWeight: FontWeight.bold, color: color),
                  ),
                  const SizedBox(height: 5),
                  SpacingColumn(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 5,
                    children: timeline.timelineDetails.map(
                      (e) {
                        if (e?.place?.images != null &&
                            e.place.images.length > 0) {
                          detailHasImageCount++;
                        }

                        return TimelineDetailWidget(
                          timelineDetail: e,
                          isRightImage: (detailHasImageCount & 0x01) != 0,
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMilestones(BuildContext context, int index,
      {bool isLast = false, Color color = DesignColor.darkestGreen}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              color: color,
            ),
            width: 20,
            height: 20,
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: context.textTheme.body1
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                color: color,
              ),
            )
        ],
      ),
    );
  }
}
