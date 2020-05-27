library friend_buttons;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';
import 'package:base/base.dart';

part 'blue_friend_button.dart';

_onButtonPressed(BuildContext context, SimpleUser user, FriendType friendType) {
  Toast.show(Strings.common.developingFeature, context);
}

String _getButtonText(FriendType friendType) {
  switch (friendType) {
    case FriendType.waiting:
      return 'Đã gửi';
    case FriendType.requesting:
      return 'Xác nhận';
    case FriendType.accepted:
      return 'Bạn bè';
    case FriendType.none:
    default:
      return 'Kết bạn';
  }
}

bool _isEnable(FriendType friendType) =>
    friendType == FriendType.none || friendType == FriendType.requesting;
