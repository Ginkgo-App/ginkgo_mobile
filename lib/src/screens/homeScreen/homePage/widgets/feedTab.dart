import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/activityBox.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';

class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SpacingColumn(
        spacing: 10,
        children: List.generate(4, (_) => ActivityBox()),
      ),
    );
  }
}
