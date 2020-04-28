import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ActivityBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.activity,
      title: 'Hoạt động',

    );
  }

}