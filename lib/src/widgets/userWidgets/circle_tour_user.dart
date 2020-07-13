part of user_widgets;

class CircleTourUser extends StatelessWidget {
  final SimpleUser simpleUser;

  const CircleTourUser({Key key, @required this.simpleUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: simpleUser == null,
      child: GestureDetector(
        onTap: () {
          if (!CurrentUserBloc().isCurrentUser(simpleUser: simpleUser)) {
            Navigators.appNavigator.currentState
                .pushNamed(Routes.user, arguments: UserScreenArgs(simpleUser));
          }
        },
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: DesignColor.backgroundColorShadow,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: CachedNetworkImage(
                  imageUrl: simpleUser?.avatar?.smallSquare ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (c, _) {
                    return Image.asset(
                      Assets.images.defaultAvatar,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SkeletonItem(
              child: Text(
                simpleUser?.displayName ?? 'HierenLee',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SkeletonItem(
              child: Text(
                simpleUser?.job ?? 'Coder',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SkeletonItem(
              child: Stack(
                children: <Widget>[
                  Container(
                    child: SvgPicture.asset(
                      Assets.icons.ribbon,
                      width: 80,
                      height: 15,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        (simpleUser?.tourCount?.toString() ?? '0') +
                            ' chuyến đi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
