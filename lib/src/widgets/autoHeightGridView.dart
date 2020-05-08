import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';

class AutoHeightGridView extends StatelessWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final int crossAxisCount;
  final List<Widget> children;

  const AutoHeightGridView(
      {Key key,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.crossAxisCount,
      this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var i = 0; i < children.length / crossAxisCount; i++) {
      final endIndex = i * crossAxisCount + crossAxisCount;
      final items = children.sublist(
          i * crossAxisCount, endIndex > children.length ? null : endIndex);

      if (items.length < crossAxisCount) {
        items.addAll(
          List.generate(
            crossAxisCount - items.length,
            (i) => const SizedBox.shrink(),
          ),
        );
      }

      rows.add(IntrinsicHeight(
        child: SpacingRow(
          spacing: crossAxisSpacing,
          children: items.map((e) => Flexible(child: e, flex: 1)).toList(),
        ),
      ));
    }

    return SpacingColumn(
      spacing: mainAxisSpacing,
      children: rows,
    );
  }
}
