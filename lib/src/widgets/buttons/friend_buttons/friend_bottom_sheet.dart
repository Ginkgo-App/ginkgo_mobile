part of 'friend_buttons.dart';

showFriendMenuBottomSheet(BuildContext context, SimpleUser user) {
  if (user.friendType != FriendType.accepted) {
    Toast.show('Không thể mở menu vì chưa là bạn bè', context);
  }

  final AddFriendBloc addFriendBloc = AddFriendBloc();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: context.colorScheme.onSurface),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: ImageWidget(
                          user?.avatar?.mediumThumb ?? '',
                          width: 40,
                          height: 40,
                          isCircled: true,
                          withShadow: false,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          user.displayName ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: context.colorScheme.onBackground),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                _RowItem(
                  title: 'Nhắn tin cho ${user.displayName}',
                  pngIcon: Assets.images.message,
                  onPressed: () {
                    Toast.show(Strings.common.developingFeature, context);
                  },
                ),
                const SizedBox(height: 15),
                _RowItem(
                  title: 'Bỏ theo dõi ${user.displayName}',
                  subTitle:
                      'Không nhìn thấy bài viết của nhau nữa nhưng vẫn là bạn bè',
                  pngIcon: Assets.images.unfollow,
                  onPressed: () {
                    Toast.show(Strings.common.developingFeature, context);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                _RowItem(
                  title: 'Chặn ${user.displayName}',
                  subTitle:
                      '${user.displayName} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Ginkgo',
                  onPressed: () {
                    Toast.show(Strings.common.developingFeature, context);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                _RowItem(
                  title: 'Hủy kết bạn với ${user.displayName}',
                  subTitle: 'Xóa ${user.displayName} khỏi danh sách bạn bè',
                  isImportant: true,
                  onPressed: () {
                    showRemoveFriendConfirm(context, user).then((_) {
                      Navigator.pop(context);
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        },
      );
    },
  ).then((_) {
    addFriendBloc.close();
  });
}

class _RowItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String pngIcon;
  final Function onPressed;
  final bool isImportant;

  const _RowItem(
      {Key key,
      @required this.title,
      this.subTitle,
      this.pngIcon,
      this.onPressed,
      this.isImportant = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20),
          if (pngIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(pngIcon, width: 20, height: 20),
            ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isImportant
                      ? DesignColor.lightRed
                      : context.colorScheme.onBackground,
                ),
              ),
              if (subTitle != null)
                Text(
                  subTitle,
                  style: TextStyle(
                      fontSize: 14, color: context.colorScheme.onSurface),
                ),
            ],
          )),
        ],
      ),
    );
  }
}
