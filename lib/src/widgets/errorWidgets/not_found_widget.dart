import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:base/base.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;
  final Widget bottom;
  final bool showBorderBox;

  const NotFoundWidget({
    Key key,
    this.message = 'Không có kết quả',
    this.bottom,
    this.showBorderBox = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Column(
      children: <Widget>[
        FlareActor(
          Assets.flares.notFound,
          alignment: Alignment.center,
          sizeFromArtboard: true,
          fit: BoxFit.contain,
          animation: "Untitled",
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyText1,
        ),
        if (bottom != null) bottom,
        const SizedBox(height: 20),
      ],
    );

    return showBorderBox
        ? BorderContainer(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            childPadding: EdgeInsets.zero,
            child: child,
          )
        : child;
  }
}
