import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class AvatarWidget extends StatelessWidget {
  final User user;

  const AvatarWidget({Key key, this.user}) : super(key: key);

  _onAvatarPress() {}

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
      onTap: user != null ? _onAvatarPress : null,
      child: AspectRatio(
        aspectRatio: 375 / 424,
        child: Hero(
          tag: user?.avatar ?? 'UserAvatar',
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset(
              Assets.images.defaultImage,
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
            imageUrl: user?.avatar ?? '',
          ),
        ),
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
                user?.displayName ?? '',
                style: context.textTheme.title
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              if (user?.slogan != null && user.slogan.isNotEmpty)
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
