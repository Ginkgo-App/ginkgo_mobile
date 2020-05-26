part of '../widgets.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool isCircled;
  final bool withShadow;
  final bool isAvatar;
  final BorderRadius borderRadius;

  const ImageWidget(
    this.imageUrl, {
    Key key,
    this.width = 50,
    this.height = 50,
    this.isCircled = false,
    this.withShadow = false,
    this.isAvatar = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = isCircled ? (width > height ? height : width) : width;
    final _height = isCircled ? (width > height ? height : width) : height;

    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(isCircled ? 90 : (borderRadius ?? 0)),
        boxShadow:
            isAvatar ? DesignColor.defaultDropShadow : DesignColor.imageShadow,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: _width,
        height: _height,
        fit: BoxFit.cover,
        placeholder: (context, _) => Image.asset(
          isAvatar ? Assets.images.defaultAvatar : Assets.images.defaultImage,
          width: _width,
          height: _height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
