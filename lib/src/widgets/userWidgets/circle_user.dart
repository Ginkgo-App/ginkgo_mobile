part of user_widgets;

class CircleUser extends StatelessWidget {
  final SimpleUser user;

  const CircleUser({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToUserScreen(user);
      },
      child: Container(
        width: 90,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  boxShadow: DesignColor.backgroundColorShadow,
                  borderRadius: BorderRadius.circular(90)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: ImageWidget(
                  user.avatar?.smallThumb ?? '',
                  width: 70,
                  height: 70,
                  isCircled: true,
                  isAvatar: true,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 26,
              child: Center(
                child: Text(
                  user.displayName,
                  textAlign: TextAlign.center,
                  style: context.textTheme.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.onBackground),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            BlueFriendButton(user: user)
          ],
        ),
      ),
    );
  }
}
