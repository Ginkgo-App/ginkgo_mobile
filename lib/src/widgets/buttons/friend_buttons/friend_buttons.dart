library friend_buttons;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

part 'blue_friend_button.dart';
part 'friend_bottom_sheet.dart';

_onButtonPressed(BuildContext context, SimpleUser user) {
  Toast.show(Strings.common.developingFeature, context);
}

onConfirmFriendRequest(BuildContext context, SimpleUser user) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Text('Bạn có đồng ý kết bạn với ${user.displayName} hay không?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Đồng ý'),
          onPressed: () {
            Toast.show(Strings.common.developingFeature, context);
          },
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          child: Text('Không'),
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
        )
      ],
    ),
  );
}

onCancelFriendRequest(BuildContext context, SimpleUser user) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Text(
          'Bạn có chắn chắn muốn từ chối lời mời kết bạn của ${user.displayName} hay không?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Đồng ý'),
          onPressed: () {
            Toast.show(Strings.common.developingFeature, context);
          },
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          child: Text('Không'),
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
        )
      ],
    ),
  );
}

String _getButtonText(FriendType friendType) {
  switch (friendType) {
    case FriendType.waiting:
      return 'Đã gửi';
    case FriendType.requested:
      return 'Xác nhận';
    case FriendType.accepted:
      return 'Bạn bè';
    case FriendType.none:
      return 'Kết bạn';
  }
}

bool _isEnable(FriendType friendType) =>
    friendType == FriendType.none || friendType == FriendType.requested;
