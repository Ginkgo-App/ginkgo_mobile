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
    final child = ClipRRect(
      borderRadius: BorderRadius.circular(isCircle ? 90 : 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, _) => Image.asset(
          Assets.images.defaultAvatar,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );

    return heroTag != null
        ? Hero(
            tag: heroTag,
            child: child,
          )
        : child;
  }
}
