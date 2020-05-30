import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ServicesProvided extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: 'Các dịch vụ được cung cấp',
      flutterIcon: Assets.icons.downArrow,
      child: Column(
        children: <Widget>[
          _buildServiceItem('Xe đưa đón tận nơi chất lương 5 sao'),
          _buildServiceItem(
              'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String service) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: SpacingRow(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.brightness_1,
              size: 6,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              service,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ));
  }
}
