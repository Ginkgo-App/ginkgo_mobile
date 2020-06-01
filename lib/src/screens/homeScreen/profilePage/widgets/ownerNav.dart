import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/friend_buttons/friend_buttons.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';

class OwnerNav extends StatelessWidget {
  final Function onCustomButtonPressed;

  const OwnerNav({Key key, this.onCustomButtonPressed}) : super(key: key);

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
              onPressed: () {
                Toast.show(Strings.common.developingFeature, context);
              },
            ),
            _Button(
              imageIcon: Assets.icons.message,
              label: 'Tin nhắn',
              onPressed: () {
                Toast.show(Strings.common.developingFeature, context);
              },
            ),
            _Button(
              imageIcon: Assets.icons.friends,
              label: 'Bạn bè',
              onPressed: () {
                Navigators.appNavigator.currentState
                    .pushNamed(Routes.friendListScreen);
              },
            ),
            _Button(
              icon: Icons.more_horiz,
              label: 'Tùy chỉnh',
              onPressed: onCustomButtonPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class UserNav extends StatelessWidget {
  final SimpleUser user;
  final Function onCustomButtonPressed;

  const UserNav({Key key, this.onCustomButtonPressed, @required this.user}) : super(key: key);

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
              imageIcon: Assets.icons.message,
              label: 'Tin nhắn',
              onPressed: () {
                Toast.show(Strings.common.developingFeature, context);
              },
            ),
            _Button(
              imageIcon: getFriendNavIcon(user.friendType),
              label: getFriendButtonText(user.friendType),
              onPressed: () {
                Toast.show(Strings.common.developingFeature, context);
              },
            ),
            _Button(
              imageIcon: Assets.icons.friends,
              label: 'Bạn bè',
              onPressed: () {
                Toast.show(Strings.common.developingFeature, context);
              },
            ),
            _Button(
              icon: Icons.more_horiz,
              label: 'Tùy chỉnh',
              onPressed: () {
                Toast.show(Strings.common.developingFeature, context);
              },
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
