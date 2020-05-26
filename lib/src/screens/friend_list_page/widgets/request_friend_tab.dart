import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/autoHeightGridView.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/friend_buttons/friend_buttons.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class RequestFriendTab extends StatefulWidget {
  @override
  _RequestFriendTabState createState() => _RequestFriendTabState();
}

class _RequestFriendTabState extends State<RequestFriendTab> {
  final SimpleUser simpleUser = FakeData.simpleUser;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoHeightGridView(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: List.generate(10, (_) => _FriendListItem(user: simpleUser)),
        ),
      ),
    );
  }
}

class _FriendListItem extends StatelessWidget {
  final SimpleUser user;

  const _FriendListItem({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: user == null,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: DesignColor.defaultDropShadow,
            borderRadius: BorderRadius.circular(10),
            color: context.colorScheme.background),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            ImageWidget(
              user?.avatar?.mediumThumb ?? '',
              width: 80,
              height: 80,
              isCircled: true,
              withShadow: false,
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
                color: Colors.transparent,
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
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: context.colorScheme.onSurface, width: 0.5),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                          ),
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.check,
                            color: DesignColor.darkestGreen,
                          ),
                          onPressed: () {
                            onConfirmFriendRequest(context, user);
                          },
                          focusColor: Colors.greenAccent,
                          highlightColor: Colors.greenAccent,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: context.colorScheme.background,
                        ),
                      ),
                      Container(
                        width: 0.5,
                        decoration:
                            BoxDecoration(color: context.colorScheme.onSurface),
                      ),
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                          ),
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.close,
                            color: context.colorScheme.error,
                          ),
                          onPressed: () {
                            onCancelFriendRequest(context, user);
                          },
                          focusColor: DesignColor.lighterRed,
                          highlightColor: DesignColor.lighterRed,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          color: context.colorScheme.background,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
