import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
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
                  _showSloganbottomSheet(HomeProvider.of(context).context),
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
          return Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                {'text': 'Chỉnh sửa thông tin cá nhân', 'onPressed': () {}},
                {'text': 'Tùy chỉnh hiển thị', 'onPressed': () {}},
              ]
                  .map<Widget>(
                    (e) => FlatButton(
                      child: Text(e['text'], style: context.textTheme.body1),
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

_showSloganbottomSheet(BuildContext context) {
  showSlidingBottomSheet(context, builder: (context) {
    TextEditingController controller = TextEditingController();
    controller.text =
        'Cuộc đời là những chuyến đi...Hãy để tôi góp phần viết nên thanh xuân của bạn';

    return SlidingSheetDialog(
        elevation: 8,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.8, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: const Duration(milliseconds: 200),
        builder: (context, state) {
          return Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Chỉnh sửa câu giới thiệu',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        child: Icon(Icons.clear),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 2,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      fillColor: DesignColor.lighterPink,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: DesignColor.pink)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: DesignColor.pink)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: DesignColor.pink),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  title: 'Lưu thay đổi',
                  onPressed: () {
                    print(controller.text);
                  },
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  });
}
