import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/widgets/post_widgets/post_widget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List<Widget>.generate(
          4,
          (_) => BorderContainer(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                childPadding: EdgeInsets.all(10),
                child: [
                  PostWidget(
                    post: FakeData.post,
                    showAuthorAvatar: true,
                  ),
                  PostWidget(
                    post: FakeData.postNoImage,
                    showAuthorAvatar: true,
                  ),
                  PostWidget(
                    post: FakeData.review,
                    showAuthorAvatar: true,
                  ),
                ][Random().nextInt(3)],
              )),
    );
  }
}
