import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ServiceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CollapseContainer(
      title: 'Các dịch vụ được cung cấp',
      collapseHeight: 125,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SpacingColumn(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildServiceItem(context, 'Xe đưa đón tận nơi chất lương 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            _buildServiceItem(context,
                'Nghỉ ở homeStay ấm cúng, tiện nghi, được cộng đồng đánh giá 5 sao'),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String service) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        '•  $service',
        style: context.textTheme.body1
            .copyWith(color: context.colorScheme.onBackground),
      ),
    );
  }
}
