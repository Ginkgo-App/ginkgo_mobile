part of '../widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isLoading;
  final BorderRadius borderRadius;
  final double width;

  const PrimaryButton({
    Key key,
    this.title,
    this.onPressed,
    this.isLoading = false,
    this.borderRadius,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        width: width,
        decoration: BoxDecoration(
            gradient: GradientColor.of(context).primaryGradient,
            borderRadius: borderRadius ?? BorderRadius.circular(90)),
        child: isLoading
            ? SizedBox(
                width: 14,
                child: LoadingIndicator(
                  size: 14,
                  padding: EdgeInsets.zero,
                ),
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.button
                    .apply(color: context.colorScheme.onPrimary),
              ),
      ),
      onPressed: isLoading ? null : onPressed,
    );
  }
}
