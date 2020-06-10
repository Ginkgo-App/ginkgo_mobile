import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/base.dart';

class CommonOutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;

  const CommonOutlineButton(
      {Key key,
      this.text,
      this.onPressed,
      this.padding = const EdgeInsets.symmetric(vertical: 8)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        padding: padding,
        width: MediaQuery.of(context).size.width * .7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: context.colorScheme.primary)),
        child: Center(child: Text(text, maxLines: 1)),
      ),
      onPressed: onPressed,
    );
  }
}
