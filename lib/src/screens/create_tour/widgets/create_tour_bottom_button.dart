import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ginkgo_mobile/src/blocs/create_tour/create_tour_bloc.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/buttons/commonOutlineButton.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class CreateTourBottomButton extends StatefulWidget {
  final int currentStep;
  final Function onNextStep;
  final Function onBackStep;

  const CreateTourBottomButton(
      {Key key, this.currentStep, this.onNextStep, this.onBackStep})
      : super(key: key);

  @override
  _CreateTourBottomButtonState createState() => _CreateTourBottomButtonState();
}

class _CreateTourBottomButtonState extends State<CreateTourBottomButton> {
  bool canSubmit1 = false;
  bool canSubmit2 = false;
  bool canSubmit3 = false;

  @override
  Widget build(BuildContext context) {
    final buttonPadding = const EdgeInsets.symmetric(vertical: 8);
    final buttonTextStyle = context.textTheme.button;

    return BlocListener(
      bloc: BlocProvider.of<CreateTourBloc>(context),
      listener: (context, state) {
        if (state is CreateTourStateHaveChanged) {
          setState(() {
            if (widget.currentStep == 0) {
              canSubmit1 = state.validation;
            } else if (widget.currentStep == 1) {
              canSubmit2 = state.validation;
            } else if (widget.currentStep == 2) {
              canSubmit3 = state.validation;
            }
          });
        }
      },
      child: widget.currentStep == 1
          ? IntrinsicHeight(
              child: SpacingRow(
                spacing: 10,
                children: <Widget>[
                  Expanded(
                    child: CommonOutlineButton(
                      text: Strings.button.backStep,
                      padding: buttonPadding,
                      borderRadius: BorderRadius.circular(90),
                      onPressed: widget.onBackStep,
                      textStyle: buttonTextStyle.apply(
                          color: context.colorScheme.primary),
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      title: Strings.button.nextStep,
                      padding: buttonPadding,
                      width: double.maxFinite,
                      onPressed: canSubmit2 ? widget.onNextStep : null,
                      textStyle: buttonTextStyle.apply(
                          color: context.colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            )
          : widget.currentStep == 2
              ? IntrinsicHeight(
                  child: SpacingRow(
                    spacing: 10,
                    children: <Widget>[
                      Expanded(
                        child: CommonOutlineButton(
                          text: Strings.button.backStep,
                          padding: buttonPadding,
                          borderRadius: BorderRadius.circular(90),
                          onPressed: widget.onBackStep,
                          textStyle: buttonTextStyle.apply(
                              color: context.colorScheme.primary),
                        ),
                      ),
                      Expanded(
                        child: PrimaryButton(
                          title: Strings.button.complete,
                          width: double.maxFinite,
                          padding: buttonPadding,
                          onPressed: canSubmit3
                              ? () {
                                  BlocProvider.of<CreateTourBloc>(context)
                                      .add(CreateTourEventCreate());
                                }
                              : null,
                          textStyle: buttonTextStyle.apply(
                              color: context.colorScheme.onPrimary),
                        ),
                      ),
                    ],
                  ),
                )
              : PrimaryButton(
                  title: Strings.button.nextStep,
                  width: double.maxFinite,
                  padding: buttonPadding,
                  onPressed: canSubmit1 ? widget.onNextStep : null,
                ),
    );
  }
}
