part of widget;

class Skeleton extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final bool autoContainer;
  final Color baseColor;
  final Color highlightColor;

  const Skeleton(
      {Key key,
      @required this.child,
      this.enabled = true,
      this.autoContainer = false,
      this.baseColor,
      this.highlightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return enabled
        ? Shimmer.fromColors(
            child: autoContainer
                ? Container(
                    child: child,
                    color: context.colorScheme.background,
                  )
                : child,
            baseColor:
                enabled ? DesignColor.shimmerBackground : Colors.transparent,
            highlightColor:
                enabled ? DesignColor.shimmerHightlight : Colors.transparent,
            enabled: true,
          )
        : child;
  }
}
