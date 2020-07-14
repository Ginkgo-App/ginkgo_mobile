import 'dart:math';

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/app.dart';
import 'package:ginkgo_mobile/src/blocs/currentUser/current_user_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/user_friends/user_friends_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/navigators.dart';
import 'package:ginkgo_mobile/src/screens/screens.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/autoHeightGridView.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

import '../../../../app.dart';

class FriendList extends StatefulWidget {
  final UserFriendsBloc userFriendsBloc;
  final Function onShowAll;
  final Function onReload;

  const FriendList(
      {Key key, @required this.userFriendsBloc, this.onShowAll, this.onReload})
      : super(key: key);

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: 'Danh sách bạn bè',
      icon: Assets.icons.friendList,
      child: BlocBuilder(
        bloc: widget.userFriendsBloc,
        builder: (context, state) {
          if (state is UserFriendsStateFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error,
              onReload: widget.onReload,
            );
          } else {
            return Column(
              children: <Widget>[
                _buildList(state is UserFriendsStateSuccess
                    ? widget.userFriendsBloc.friendList.sublist(
                        0, min(6, widget.userFriendsBloc.friendList.length))
                    : null),
                if (state is UserFriendsStateSuccess)
                  if (widget.userFriendsBloc.friendList.length > 0) ...[
                    const SizedBox(height: 10),
                    CommonOutlineButton(
                      text: 'Xem tất cả danh sách bạn bè',
                      onPressed: () {
                        if (widget.onShowAll != null) {
                          widget.onShowAll();
                        } else {
                          Navigators.appNavigator.currentState.pushNamed(
                            Routes.friendListScreen,
                            arguments: FriendListScreenArgs(
                              CurrentUserBloc().currentUser.toSimpleUser(),
                            ),
                          );
                        }
                      },
                    )
                  ] else
                    Text(
                      Strings.noData.friends,
                      style: context.textTheme.bodyText2
                          .copyWith(color: context.colorScheme.onSurface),
                    )
              ],
            );
          }
        },
      ),
    );
  }

  _buildList([List<SimpleUser> users]) {
    return AutoHeightGridView(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: users != null
          ? users.map<Widget>((e) => RectRadiusUser(user: e)).toList()
          : List.generate(3, (_) => RectRadiusUser()),
    );
  }
}
