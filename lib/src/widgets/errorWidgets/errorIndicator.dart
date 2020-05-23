import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ErrorIndicator extends StatefulWidget {
  final String message;
  final String moreErrorDetail;
  final Function onReload;

  const ErrorIndicator(
      {Key key, this.message, this.moreErrorDetail, this.onReload})
      : super(key: key);

  @override
  _ErrorIndicatorState createState() => _ErrorIndicatorState();
}

class _ErrorIndicatorState extends State<ErrorIndicator> {
  bool isShowingDetail = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              isShowingDetail = !isShowingDetail;
            }),
            child: Text(
              widget.message ?? Strings.error.error,
              textAlign: TextAlign.center,
              style: context.textTheme.body1
                  .copyWith(color: context.colorScheme.error),
            ),
          ),
          isShowingDetail && widget.moreErrorDetail.isExistAndNotEmpty
              ? Text(
                  widget.moreErrorDetail,
                  style: context.textTheme.overline
                      .copyWith(color: context.colorScheme.onSurface),
                )
              : const SizedBox.shrink(),
          if (widget.onReload != null) ...[
            const SizedBox(height: 10),
            PrimaryButton(
              title: Strings.button.reload,
              onPressed: widget.onReload,
            )
          ]
        ],
      ),
    );
  }
}
