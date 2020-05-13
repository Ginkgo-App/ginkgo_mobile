import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/userFriend/user_friend_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/autoHeightGridView.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/indicators/errorIndicator.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class FriendList extends StatefulWidget {
  /// UserId = 0 is current user;
  final int userId;

  const FriendList({Key key, this.userId}) : super(key: key);

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final UserFriendBloc _bloc = UserFriendBloc();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() {
    _bloc.add(UserFriendEventFetch(widget.userId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: 'Danh sách bạn bè',
      icon: Assets.icons.friendList,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is UserFriendFailure) {
            return ErrorIndicator(
              moreErrorDetail: state.error,
              onReload: _fetchData,
            );
          } else {
            return Column(
              children: <Widget>[
                _buildList(state is UserFriendSuccess ? state.users : null),
                if (state is UserFriendSuccess)
                  if (state.users.length > 0) ...[
                    const SizedBox(height: 10),
                    CommonOutlineButton(
                      text: 'Xem tất cả danh sách bạn bè',
                      onPressed: () {},
                    )
                  ] else
                    Text(
                      Strings.noData.friends,
                      style: context.textTheme.body1
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
          ? users.map<Widget>((e) => _FriendListItem(user: e)).toList()
          : List.generate(3, (_) => _FriendListItem()),
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
                  imageUrl: user?.avatar ?? '',
                  fit: BoxFit.cover,
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
    );
  }
}
