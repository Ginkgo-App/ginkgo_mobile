import 'package:base/base.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/conversation.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

import '../widgets.dart';

class UserAvatar extends StatelessWidget {
  final MultiSizeImage image;
  final double size;
  final bool showOnline;
  final bool isOnline;

  const UserAvatar({
    Key key,
    this.image,
    this.size = 50.0,
    this.showOnline = true,
    this.isOnline = false,
  }) : super(key: key);

  factory UserAvatar.fromConversation({
    Key key,
    @required Conversation conversation,
    double size = 50,
  }) {
    return UserAvatar(
      key: key,
      image: conversation?.image,
      size: size,
      showOnline: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: size,
          height: size,
          child: ImageWidget(
            image?.smallThumb ?? '',
            isAvatar: true,
            isCircled: true,
          ),
        ),
        if (showOnline)
          Positioned(
            bottom: size * 0.05,
            right: size * 0.05,
            child: Container(
              width: 14 * size / 50,
              height: 14 * size / 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.background,
                  width: 2,
                ),
                color: Color(isOnline ? 0xff20FF6C : 0xff7D7D7D),
              ),
            ),
          )
      ],
    );
  }
}
