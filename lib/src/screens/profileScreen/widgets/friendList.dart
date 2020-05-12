import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/blocs/userFriend/user_friend_bloc.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/autoHeightGridView.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class Demo {
  final String image;
  final String name;
  final String job;
  Demo({
    this.image,
    this.job,
    this.name,
  });
}

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
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
        title: 'Danh sách bạn bè',
        icon: Assets.icons.friendList,
        children: <Widget>[
          _buildList(),
          const SizedBox(height: 10),
          CommonOutlineButton(
            text: 'Xem tat ca',
            onPressed: () {},
          )
        ]);
  }

  _buildList() {
    List<Demo> demo = [
      Demo(
          image:
              'https://avatars3.githubusercontent.com/u/36977998?s=400&u=7c2d7d85fb631b8e71df22c7f0949a67cbd78e9b&v=4',
          name: 'hienLe',
          job: 'PM'),
      Demo(
          image:
              'https://avatars0.githubusercontent.com/u/36978155?s=460&u=2369912b5e7ac421e52057e458b4b62dda4b0f28&v=4',
          name: 'Duy mập',
          job: 'Thần gió'),
      Demo(
          image:
              'https://avatars1.githubusercontent.com/u/48937704?s=460&u=31ac71631f7d5d9325f963159f7da7809fb431f7&v=4',
          name: 'Ikemen',
          job: 'Ăn hại'),
      Demo(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTPhKIScX_qtdk-wM-KKQ65MeMhvHh929B4RJTkmJxsgSa9gW8K&usqp=CAU',
          name: 'minatozaki sana',
          job: 'Angel'),
      Demo(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTPhKIScX_qtdk-wM-KKQ65MeMhvHh929B4RJTkmJxsgSa9gW8K&usqp=CAU',
          name: 'minatozaki sana',
          job: 'Angel'),
      Demo(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTPhKIScX_qtdk-wM-KKQ65MeMhvHh929B4RJTkmJxsgSa9gW8K&usqp=CAU',
          name: 'minatozaki sana',
          job: 'Angel'),
    ];

    return AutoHeightGridView(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: demo.map((e) => _buildItem(e)).toList(),
    );
  }

  Widget _buildItem(Demo data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: data.image,
              fit: BoxFit.cover,
            )),
        SizedBox(
          height: 5,
        ),
        Text(
          data.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          data.job,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 12, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
