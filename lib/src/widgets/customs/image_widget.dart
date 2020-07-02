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
    this.width,
    this.height,
    this.isCircled = false,
    this.withShadow = false,
    this.isAvatar = false,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(isCircled ? 90 : (borderRadius ?? 0)),
        boxShadow: !withShadow
            ? null
            : (isAvatar
                ? DesignColor.defaultDropShadow
                : DesignColor.imageShadow),
      ),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(isCircled ? 90 : (borderRadius ?? 0)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          placeholder: (context, _) => Image.asset(
            isAvatar ? Assets.images.defaultAvatar : Assets.images.defaultImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
