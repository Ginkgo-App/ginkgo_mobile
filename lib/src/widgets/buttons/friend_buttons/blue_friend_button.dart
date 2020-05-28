part of 'friend_buttons.dart';

class BlueFriendButton extends StatelessWidget {
  final SimpleUser user;

  ///
  /// Mặc định, khi nhấn nút confirm request thì sẽ đồng ý kết bạn.
  /// Nếu muốn tác vụ khác như mở trang friend thì truyền vào đây.
  final Function(SimpleUser user) onConfirmRequest;

  const BlueFriendButton({Key key, @required this.user, this.onConfirmRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _isEnable(user.friendType)
        ? DesignColor.darkestBlue
        : DesignColor.darkerBlue;
    return CupertinoButton(
      onPressed: _isEnable(user.friendType)
          ? () {
              if (user.friendType == FriendType.requested &&
                  onConfirmRequest != null) {
                onConfirmRequest(user);
              } else {
                _onButtonPressed(context, user);
              }
            }
          : null,
      padding: EdgeInsets.zero,
      child: Container(
        width: 70,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color, width: 0.5),
        ),
        child: Text(
          _getButtonText(user.friendType),
          textAlign: TextAlign.center,
          style: context.textTheme.caption.copyWith(color: color),
        ),
      ),
    );
  }
}
