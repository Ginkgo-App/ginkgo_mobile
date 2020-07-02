import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/constrains.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:base/base.dart';

class MembersBottomSheet {
  final BuildContext context;
  final int tourId;

  MembersBottomSheet(this.context, {@required this.tourId})
      : assert(tourId != null);

  Future show() async {
    return showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        snapSpec: SnapSpec(snappings: [0.9]),
        cornerRadius: 10,
        color: context.colorScheme.background,
        headerBuilder: (context, state) {
          return Material(
            color: context.colorScheme.background,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 1, color: context.colorScheme.surface),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpacingRow(
                  spacing: 10,
                  children: <Widget>[
                    Icon(Icons.people, color: DesignColor.darkestBlue),
                    Text(
                      '30 thành viên',
                      style: context.textTheme.subtitle1.copyWith(
                        color: DesignColor.darkestBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        builder: (context, state) {
          final data = List.generate(
            10,
            (index) => TourMember(
              avatar: MultiSizeImage('https://i.imgur.com/ePEkVUYb.jpg'),
              id: 1,
              job: 'an khong ngoi roi',
              name: 'Ăn hại',
              tourCount: 15,
              friendType: FriendType.accepted,
              acceptedAt: DateTime.now().subtract(Duration(days: 2)),
              joinAt: DateTime.now().subtract(Duration(days: 3)),
            ),
          );
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              itemCount: data.length,
              itemExtent: null,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return _TourMemberItem(tourMember: data[i]);
              },
            ),
          );
        },
      );
    });
  }
}

class _TourMemberItem extends StatelessWidget {
  final TourMember tourMember;

  const _TourMemberItem({Key key, this.tourMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          boxShadow: DesignColor.defaultDropShadow,
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Skeleton(
          enabled: tourMember == null,
          child: SpacingRow(
            spacing: 10,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SkeletonItem(
                  child: CachedNetworkImage(
                    imageUrl: tourMember?.avatar?.mediumThumb,
                    width: 100,
                    height: 100,
                    placeholder: (c, _) => Constains.defaultAvatar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[Text(tourMember?.displayName)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
