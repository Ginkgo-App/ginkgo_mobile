import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/screens/profileScreen/widgets/tourItemWidget.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class TourListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.tour,
      title: 'Các chuyến đi',
      childPadding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: IntrinsicHeight(
              child: SpacingRow(
                spacing: 10,
                children: List.generate(10, (i) {
                  return TourItemWidget();
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CommonOutlineButton(
            text: 'Xem tất cả các chuyến đi',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
