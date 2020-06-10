import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/base.dart';

class CommonOutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final TextStyle textStyle;

  const CommonOutlineButton({
    Key key,
    this.text,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
    this.borderRadius,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Container(
        padding: padding,
        width: MediaQuery.of(context).size.width * .7,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          border: Border.all(color: context.colorScheme.primary),
        ),
        child: Center(child: Text(text, style: textStyle, maxLines: 1)),
      ),
      onPressed: onPressed,
    );
  }
}
