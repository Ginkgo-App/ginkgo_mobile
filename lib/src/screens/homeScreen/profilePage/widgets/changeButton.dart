import 'package:flutter/material.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ChangeButton extends StatelessWidget {
  final bool isEditing;
  final bool isLoading;
  final VoidCallback onTap;

  const ChangeButton({
    Key key,
    this.onTap,
    this.isEditing = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingIndicator(
            size: 10,
            padding: EdgeInsets.zero,
            color: DesignColor.lighterRed,
          )
        : GestureDetector(
            onTap: onTap,
            child: Text(
              (isEditing ? Strings.button.saveChanges : Strings.button.edit)
                  .toUpperCase(),
              style: context.textTheme.bodyText2.copyWith(color: DesignColor.cta),
            ),
          );
  }
}
