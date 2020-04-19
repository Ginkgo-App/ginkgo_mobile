part of 'widgets.dart';

class LoadingIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final Color color;
  final double size;

  const LoadingIndicator(
      {Key key, this.padding = const EdgeInsets.all(10), this.color, this.size = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SpinKitFadingCube(
        color: color ?? context.colorScheme.onPrimary,
        size: size,
      ),
    );
  }
}
