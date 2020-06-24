import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/post_widgets/post_widget.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ActivityBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.activity,
      title: 'Hoạt động',
      childPadding: EdgeInsets.all(10),
      child: SpacingColumn(
        spacing: 20,
        children: [
          PostWidget(
            post: FakeData.post,
            showAuthorAvatar: true,
          ),
          PostWidget(
            post: FakeData.postNoImage,
          ),
          PostWidget(
            post: FakeData.review,
          ),
        ],
      ),
    );
  }
}
