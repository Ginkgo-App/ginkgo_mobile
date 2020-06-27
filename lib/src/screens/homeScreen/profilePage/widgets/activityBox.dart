import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/post_widgets/post_widget.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class ActivityBox extends StatelessWidget {
  const ActivityBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.activity,
      title: 'Hoạt động',
      childPadding: EdgeInsets.all(10),
      child: ListView(
        itemExtent: null,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          PostWidget(
            post: FakeData.post,
          ),
          PostWidget(
            post: FakeData.postNoImage,
          ),
          PostWidget(
            post: FakeData.review,
          ),
        ].addBetweenEvery(SizedBox(height: 20)),
      ),
    );
  }
}
