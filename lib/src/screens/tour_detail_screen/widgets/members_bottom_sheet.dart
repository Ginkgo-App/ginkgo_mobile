import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/friend_buttons/friend_buttons.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class MembersBottomSheet {
  final BuildContext context;
  final int tourId;
  final bool isHost;

  MembersBottomSheet(this.context, {@required this.tourId, this.isHost = false})
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
                return _TourMemberItem(
                  tourMember: data[i],
                  isHost: isHost,
                );
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
  final bool isHost;

  const _TourMemberItem({Key key, this.tourMember, this.isHost = false})
      : super(key: key);

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
                    placeholder: (c, _) => Image.asset(
                      Assets.images.defaultAvatar,
                      width: 100,
                      height: 100,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(tourMember?.displayName,
                        style: context.textTheme.bodyText1),
                    Text(tourMember?.job, style: context.textTheme.bodyText2),
                  ],
                ),
              ),
              if (isHost ?? true)
                _BlueMemberButton(
                  isMember: tourMember.isMember,
                  onPressed: _showMenuBottomSheet(context, tourMember),
                )
              else
                BlueFriendButton(user: tourMember),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlueMemberButton extends StatelessWidget {
  final bool isMember;
  final Function onPressed;

  const _BlueMemberButton({Key key, this.isMember = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = DesignColor.cta;

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color, width: 0.5),
          color: isMember ? color : Colors.transparent,
        ),
        child: SpacingRow(
          spacing: 3,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isMember ? 'Đã duyệt' : 'Đang đợi',
              textAlign: TextAlign.center,
              style: context.textTheme.caption
                  .copyWith(color: isMember ? Colors.white : color),
            ),
            SvgPicture.asset(
              isMember ? Assets.icons.tick : Assets.icons.waiting,
              color: isMember ? Colors.white : DesignColor.cta,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

_showMenuBottomSheet(BuildContext context, TourMember tourMember) {
  showSlidingBottomSheet(
    context,
    builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        duration: const Duration(milliseconds: 200),
        builder: (context, state) {
          return Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!tourMember.isMember)
                  {
                    'text': 'Xét duyệt ${tourMember.displayName}',
                    'onPressed': () {
                      Navigator.pop(context);
                    }
                  },
                if (!tourMember.isMember)
                  {
                    'text': 'Từ chối ${tourMember.displayName}',
                    'onPressed': () {
                      Navigator.pop(context);
                    }
                  },
                if (tourMember.isMember)
                  {
                    'text':
                        'Loại ${tourMember.displayName} khỏi danh sách tham gia',
                    'onPressed': () {
                      Navigator.pop(context);
                    }
                  },
              ]
                  .map<Widget>(
                    (e) => FlatButton(
                      child:
                          Text(e['text'], style: context.textTheme.bodyText2),
                      color: context.colorScheme.background,
                      highlightColor: DesignColor.darkestWhite,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: e['onPressed'],
                    ),
                  )
                  .toList()
                  .addBetweenEvery(
                    Container(
                      height: 0.5,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: DesignColor.lightestBlack,
                    ),
                  ),
            ),
          );
        },
      );
    },
  );
}
