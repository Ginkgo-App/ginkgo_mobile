import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class AboutBox extends StatefulWidget {
  final User user;

  const AboutBox({Key key, this.user}) : super(key: key);

  @override
  _AboutBoxState createState() => _AboutBoxState();
}

class _AboutBoxState extends State<AboutBox> {
  bool isShowFull = false;

  @override
  Widget build(BuildContext context) {
    return widget?.user?.bio != null && widget.user.bio.isNotEmpty
        ? BorderContainer(
            title: 'Tự giới thiệu',
            icon: Assets.icons.introduction,
            child: HiddenText(widget.user.bio),
          )
        : const SizedBox.shrink();
  }
}
