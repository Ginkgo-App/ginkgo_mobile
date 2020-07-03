import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ServiceList extends StatelessWidget {
  final List<String> services;

  const ServiceList({Key key, this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CollapseContainer(
      title: 'Các dịch vụ được cung cấp',
      collapseHeight: 125,
      child: Skeleton(
        enabled: services == null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: SpacingColumn(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: services == null
                  ? List.generate(5, (index) => _buildServiceItem(context, ''))
                  : services
                      .map((e) => _buildServiceItem(context, e))
                      .toList()),
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String service) {
    return Container(
      color: context.colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        '•  $service',
        style: context.textTheme.bodyText2
            .copyWith(color: context.colorScheme.onBackground),
      ),
    );
  }
}
