part of widget;

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool isCircle;

  const Avatar({Key key, @required this.imageUrl, this.size = 30, this.isCircle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isCircle ? 90 : 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, _) => Image.asset(
          Assets.images.defaultImage,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
