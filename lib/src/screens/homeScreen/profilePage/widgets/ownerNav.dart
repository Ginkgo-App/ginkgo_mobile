import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/models/conversation_key.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/message_screen/message_screen.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/friend_buttons/friend_buttons.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';

class OwnerNav extends StatelessWidget {
  final Function onCreatePostPressed;
  final Function onCustomButtonPressed;

  const OwnerNav(
      {Key key, this.onCustomButtonPressed, this.onCreatePostPressed})
      : super(key: key);

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
              onPressed: onCreatePostPressed,
            ),
            _Button(
              imageIcon: Assets.icons.message,
              label: 'Tin nhắn',
              onPressed: () {
                Navigators.appNavigator.currentState.pushNamed(Routes.chatList);
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
  final Function onFriendActionSuccess;

  const UserNav(
      {Key key,
      this.onCustomButtonPressed,
      @required this.user,
      this.onFriendActionSuccess})
      : super(key: key);

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
                Navigator.pushNamed(context, Routes.message,
                    arguments: MessagesScreenArgs(
                        conversationKey:
                            ConversationKey(targetUserId: user.id)));
              },
            ),
            _Button(
              imageIcon: getFriendNavIcon(user.friendType),
              label: getFriendButtonText(user.friendType),
              onPressed: () {
                getFriendAction(context, user,
                    onSuccess: onFriendActionSuccess)();
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
