part of 'friend_buttons.dart';

showFriendMenuBottomSheet(BuildContext context, SimpleUser user) {
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        Assets.images.message,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      'Nhắn tin cho ${user.displayName}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        Assets.images.unfollow,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Bỏ theo dõi ${user.displayName}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Không nhìn thấy bài viết của nhau nữa nhưng vẫn là bạn bè',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.colorScheme.onSurface),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 20,
                      height: 20,
                      child: Image.asset(Assets.images.unfollow),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Chặn ${user.displayName}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${user.displayName} sẽ không thể nhìn thấy bạn hoặc liên hệ với bạn trên Ginkgo',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: context.colorScheme.onSurface),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 20,
                      height: 20,
                      child: Image.asset(Assets.images.unfollow),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hủy kết bạn với ${user.displayName}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: DesignColor.lightRed,
                          ),
                        ),
                        Text(
                          'Xóa ${user.displayName} khỏi danh sách bạn bè',
                          style: TextStyle(
                              fontSize: 14,
                              color: context.colorScheme.onSurface),
                        ),
                      ],
                    )),
                  ],
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
  );
}
