library create_tour_tabs;

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/blocs/create_tour/create_tour_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/create_tour/widgets/create_tour_add_button.dart';
import 'package:ginkgo_mobile/src/screens/create_tour/widgets/input_increment_decrement.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/actionSheets/show_custom_date_picker.dart';
import 'package:ginkgo_mobile/src/widgets/dotted_border/dotted_border.dart';
import 'package:ginkgo_mobile/src/widgets/errorWidgets/showErrorMessage.dart';
import 'package:ginkgo_mobile/src/widgets/gradientOutlineBorder.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

part 'create_tour_tab1.dart';
part 'create_tour_tab2.dart';
part 'create_tour_tab3.dart';

class _CreateTourTextFieldBase extends StatelessWidget {
  final bool isRequired;
  final String label;
  final Widget textInput;
  final String unit;

  const _CreateTourTextFieldBase({
    Key key,
    this.isRequired,
    this.label,
    this.textInput,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacingColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 5,
      children: <Widget>[
        if (label.isExistAndNotEmpty)
          RichText(
            text: TextSpan(
              text: !isRequired ? '' : '* ',
              style: context.textTheme.body1
                  .copyWith(color: context.colorScheme.error),
              children: [
                TextSpan(
                  text: label,
                  style: TextStyle(color: context.colorScheme.onBackground),
                )
              ],
            ),
          ),
        SpacingRow(
          spacing: 5,
          children: <Widget>[
            Expanded(child: textInput),
            if (unit.isExistAndNotEmpty)
              Text(
                unit,
                style: context.textTheme.body1.copyWith(
                    fontStyle: FontStyle.italic,
                    color: DesignColor.lightestBlack),
              )
          ],
        ),
      ],
    );
  }
}