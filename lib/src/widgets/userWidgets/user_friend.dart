part of '../widgets.dart';

class UserFriendWidget extends StatelessWidget {
  final SimpleUser user;
  final bool readonly;

  const UserFriendWidget({Key key, this.user, this.readonly = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = user == null;

    return GestureDetector(
      onTap: () {
        Navigators.appNavigator.currentState
            .pushNamed(Routes.user, arguments: UserScreenArgs(user));
      },
      child: Skeleton(
        enabled: isLoading,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: DesignColor.defaultDropShadow,
              borderRadius: BorderRadius.circular(10),
              color: context.colorScheme.background),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!readonly &&
                  !isLoading &&
                  user.friendType == FriendType.accepted) ...[
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.more_horiz),
                      ),
                      onTap: () {
                        showFriendMenuBottomSheet(context, user);
                      },
                    )
                  ],
                ),
              ] else
                const SizedBox(height: 20),
              Center(
                child: ImageWidget(
                  user?.avatar?.mediumThumb ?? '',
                  width: 80,
                  height: 80,
                  isCircled: true,
                  withShadow: false,
                  isAvatar: true,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user?.name ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user?.job ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              if (!readonly &&
                  !isLoading &&
                  user.friendType == FriendType.requested)
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
                          decoration: BoxDecoration(
                              color: context.colorScheme.onSurface),
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
            ],
          ),
        ),
      ),
    );
  }
}
