part of widget;

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;

  const Avatar({Key key, @required this.imageUrl, this.size = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 30,
        height: 30,
        // TODO build placeholder
        placeholder: (contextx, _) => Container(),
      ),
    );
  }
}
