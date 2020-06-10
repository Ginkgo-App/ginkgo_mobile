import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;
  final Widget bottom;

  const NotFoundWidget({
    Key key,
    this.message = 'Không có kết quả',
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      color: Colors.white,
      margin: EdgeInsets.all(10),
      childPadding: EdgeInsets.zero,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(Assets.images.notFound),
        ),
        Transform.translate(
          offset: Offset(0, -15),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.body2,
          ),
        ),
        if (bottom != null) bottom,
        const SizedBox(height: 20),
      ],
    );
  }
}
