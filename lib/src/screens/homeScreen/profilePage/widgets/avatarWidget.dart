import 'dart:io';

import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/update_profile/update_profile_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/heroKeys.dart';
import 'package:ginkgo_mobile/src/widgets/actionSheets/pickImageActionSheet.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class AvatarWidget extends StatefulWidget {
  final User user;
  final bool editable;

  const AvatarWidget({Key key, @required this.user, this.editable = false})
      : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  final UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();

  _onAvatarPress() {
    // TODO handle show dialog image.
  }

  _onUpdateAvatarPress(BuildContext context) {
    pickImage(HomeProvider.of(context).context, _onPickImageSuccess);
  }

  _onPickImageSuccess(File image) async {
    if (image != null) {
      updateProfileBloc.add(UpdateProfileEventUpdate(UserToPut(avatar: image)));
    }
  }

  @override
  void dispose() {
    updateProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: updateProfileBloc,
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            _buildAvatar(context),
            if (widget.editable) _buildCameraButton(context),
            _buildInfoBox(context),
            if (state is UpdateProfileStateLoading)
              Positioned.fill(
                  child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: LoadingIndicator(),
                ),
              ))
          ],
        );
      },
    );
  }

  _buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: widget.user != null ? _onAvatarPress : null,
      child: AspectRatio(
        aspectRatio: 375 / 424,
        child: Hero(
          tag: HeroKeys.currentUserAvatar,
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset(
              Assets.images.defaultAvatar,
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
            imageUrl: widget.user?.avatar?.largeThumb ?? '',
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
        onPressed: () => _onUpdateAvatarPress(context),
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
                widget.user?.displayName ?? '',
                style: context.textTheme.title
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              if (widget.user?.slogan != null &&
                  widget.user.slogan.isNotEmpty) ...[
                SizedBox(
                  height: 14,
                ),
                Text(
                  widget.user.slogan,
                  style: context.textTheme.body1.copyWith(color: Colors.white),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
