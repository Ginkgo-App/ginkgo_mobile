part of '../../screens.dart';

class NotificationWidget extends StatelessWidget {
  final Notification notification;

  const NotificationWidget({Key key, @required this.notification})
      : assert(notification != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        color: notification.readAt != null
            ? Colors.white
            : DesignColor.shimmerBackground,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SvgPicture.asset(
                Assets.icons.messageNew,
                height: 30,
                width: 30,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(
                        text: notification.message + ' ',
                        style: context.textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: notification.payload,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    notification.readAt.toVietNamese(withTime: true),
                    style: context.textTheme.bodyText2.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Divider(
            color: Colors.grey,
            height: 0,
            thickness: 0.5,
            indent: 70,
            endIndent: 0,
          ),
        ),
      ),
    ]);
  }
}
