import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/widgets/dotted_border/dotted_border.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:base/base.dart';

class ProgressBar extends StatelessWidget {
  static const ENABLE_COLOR = Colors.red;
  static const DISABLE_COLOR = Colors.white;
  static const buttonTexts = [
    'Thông tin cơ bản',
    'Thời gian, dịch vụ',
    'Lịch trình chi tiết',
  ];

  final int currentIndex;
  final Function(int) onPageChanged;

  const ProgressBar({Key key, this.currentIndex = 0, this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 50,
            right: 50,
            top: 20,
            child: SpacingRow(
              children: [
                Expanded(child: buildLine(currentIndex >= 0)),
                Expanded(child: buildLine(currentIndex >= 1)),
              ],
            ),
          ),
          SpacingRow(
            children: List.generate(
              3,
              (i) => buildPoint(context, i, currentIndex >= i),
            ).addBetweenEvery(Expanded(child: const SizedBox.shrink())),
          ),
        ],
      ),
    );
  }

  Widget buildPoint(BuildContext context, int index, bool isEnable) {
    return InkWell(
      onTap: () {
        onPageChanged?.call(index);
      },
      child: Column(
        children: <Widget>[
          DottedBorder(
            borderType: BorderType.Circle,
            padding: EdgeInsets.zero,
            color: isEnable ? Colors.transparent : ENABLE_COLOR,
            dashPattern: [3, 3],
            strokeWidth: 1,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isEnable ? ENABLE_COLOR : DISABLE_COLOR,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: context.textTheme.title.copyWith(
                      color: isEnable ? DISABLE_COLOR : ENABLE_COLOR),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            buttonTexts[index],
            style: context.textTheme.body1.copyWith(
              color: isEnable ? ENABLE_COLOR : Colors.black,
              fontWeight: isEnable ? FontWeight.bold : FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  Widget buildLine(bool isEnable) {
    return isEnable
        ? Container(height: 2, color: ENABLE_COLOR)
        : _Separator(height: 2, color: ENABLE_COLOR);
  }
}

class _Separator extends StatelessWidget {
  final double height;
  final Color color;

  const _Separator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
