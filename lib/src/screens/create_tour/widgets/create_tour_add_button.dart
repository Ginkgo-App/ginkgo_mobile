import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/dotted_border/dotted_border.dart';
import 'package:base/base.dart';

class CreateTourAddButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const CreateTourAddButton({Key key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: DesignColor.lighterBlack,
          radius: Radius.circular(5),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: DesignColor.lighterBlack,
              ),
              Text(
                text ?? 'Thêm',
                style: context.textTheme.body1
                    .copyWith(color: DesignColor.lighterBlack),
              )
            ],
          ),
        ),
        onPressed: onPressed);
  }
}
