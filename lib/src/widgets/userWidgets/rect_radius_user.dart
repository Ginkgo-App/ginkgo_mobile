part of 'user_widgets.dart';

class RectRadiusUser extends StatelessWidget {
  final SimpleUser user;

  const RectRadiusUser({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: user == null,
      child: GestureDetector(
        onTap: () {
          _navigateToUserScreen(user);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: user?.avatar?.mediumThumb ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, _) {
                      return Image.asset(
                        Assets.images.defaultAvatar,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: context.colorScheme.background,
              child: Text(
                user?.name ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (user == null || user.job.isExistAndNotEmpty) ...[
              SizedBox(
                height: 5,
              ),
              Container(
                color: context.colorScheme.background,
                margin: EdgeInsets.symmetric(horizontal: user != null ? 0 : 20),
                child: Text(
                  user?.job ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
