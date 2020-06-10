part of widget;

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool isCircle;
  final String heroTag;

  const Avatar(
      {Key key,
      @required this.imageUrl,
      this.size = 30,
      this.isCircle = true,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = ImageWidget(
      imageUrl,
      width: size,
      height: size,
      isCircled: true,
      withShadow: false,
    );

    return heroTag != null
        ? Hero(
            tag: heroTag,
            child: child,
          )
        : child;
  }
}
