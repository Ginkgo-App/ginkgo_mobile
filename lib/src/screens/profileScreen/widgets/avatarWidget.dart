import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';

class AvatarWidget extends StatelessWidget {
  final User user;

  const AvatarWidget({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildAvatar(context),
        _buildCameraButton(context),
        _buildInfoBox(context),
      ],
    );
  }

  _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AspectRatio(
        child: Hero(
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset(
              'assets/images/default-avatar.png',
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
            imageUrl: user.avatar,
          ),
          tag: user.avatar,
        ),
        aspectRatio: 375 / 424,
      ),
    );
  }

  _buildCameraButton(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      child: CupertinoButton(
        child: Icon(Icons.camera_alt, color: Colors.white),
        color: Color.fromRGBO(0, 0, 0, 0.5),
        padding: EdgeInsets.zero,
        onPressed: () {},
      ),
    );
  }

  _buildInfoBox(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(127, 0, 0, 0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.fullName,
                style: context.textTheme.title
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                user.slogan,
                style: context.textTheme.body1.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
