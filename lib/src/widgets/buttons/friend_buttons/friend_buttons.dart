library friend_buttons;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/blocs/add_friend/add_friend_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/LoadingManager.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/showErrorMessage.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

part 'blue_friend_button.dart';
part 'friend_bottom_sheet.dart';

_onButtonPressed(BuildContext context, SimpleUser user) {
  Toast.show(Strings.common.developingFeature, context);
}

Future onConfirmFriendRequest(BuildContext context, SimpleUser user,
        {Function onSuccess}) =>
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content:
            Text('Bạn có đồng ý kết bạn với ${user.displayName} hay không?'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Đồng ý'),
            onPressed: () {
              Navigator.pop(context);
              final AddFriendBloc addFriendBloc = AddFriendBloc();
              addFriendBloc.add(AddFriendEventAcceptFriend(user));

              addFriendBloc.listen((state) {
                if (state is AddFriendStateLoading) {
                  LoadingManager().show(context);
                  return;
                } else if (state is AddFriendStateFailure) {
                  showErrorMessage(context,
                      Strings.error.error + '\n' + state.error.toString());
                }

                onSuccess?.call();
                LoadingManager().hide(context);
                addFriendBloc.close();
              });
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

onRemoveFriend(BuildContext context, SimpleUser user, Function onRemove) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      content: Text(
          'Bạn có chắc chắn muốn hủy kết bạn với ${user.displayName} hay không?'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Đồng ý'),
          onPressed: () {
            Navigator.of(context).pop();
            onRemove();
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
    default:
      return 'Kết bạn';
  }
}

bool _isEnable(FriendType friendType) =>
    friendType == FriendType.none || friendType == FriendType.requested;
