import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class OwnerNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: DesignColor.backgroundColorShadow,
        color: context.colorScheme.background,
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _Button(
              imageIcon: Assets.icons.createPost,
              label: 'Đăng bài',
              onPressed: () {},
            ),
            _Button(
              imageIcon: Assets.icons.message,
              label: 'Tin nhắn',
              onPressed: () {},
            ),
            _Button(
              imageIcon: Assets.icons.friends,
              label: 'Bạn bè',
              onPressed: () {},
            ),
            _Button(
              icon: Icons.more_horiz,
              label: 'Tùy chỉnh',
              onPressed: () =>
                  _showMenuBottomSheet(HomeProvider.of(context).context),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String imageIcon;
  final IconData icon;
  final String label;
  final Function onPressed;
  static const ICON_HEIGHT = 25.0;

  const _Button(
      {Key key, this.imageIcon, this.icon, this.onPressed, this.label})
      : assert(imageIcon == null || icon == null),
        assert(imageIcon != null || icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: <Widget>[
          imageIcon != null
              ? SvgPicture.asset(imageIcon, height: ICON_HEIGHT)
              : Icon(icon, color: Colors.black, size: ICON_HEIGHT),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.black),
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}

_showMenuBottomSheet(BuildContext context) {
  showSlidingBottomSheet(
    context,
    builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.8, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: const Duration(milliseconds: 200),
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Text('Chỉnh sửa thông tin cá nhân'),
              Text('Tùy chỉnh hiển thị'),
            ],
          );
        },
      );
    },
  );
}
