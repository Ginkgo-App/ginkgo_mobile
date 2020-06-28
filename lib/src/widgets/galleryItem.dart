import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:base/base.dart';

const _SPACING = 5.0;

class GalleryItem extends StatelessWidget {
  final List<String> images;
  final BorderRadius borderRadius;
  final Function onPressed;

  const GalleryItem({Key key, this.images, this.borderRadius, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    if (images.length < 0) {
      return const SizedBox.shrink();
    } else if (images.length == 0) {
      return _buildImage('');
    } else if (images.length == 1) {
      return _buildImage(images[0]);
    } else if (images.length == 2) {
      return _build2Images();
    } else {
      return _buildMoreImages(context);
    }
  }

  _build2Images() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 3, child: _buildImage(images[0])),
          const SizedBox(width: _SPACING),
          Expanded(flex: 2, child: _buildImage(images[1])),
        ],
      ),
    );
  }

  _buildMoreImages(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 3, child: _buildImage(images[0])),
          const SizedBox(width: _SPACING),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: _buildImage(images[1]),
                  ),
                  const SizedBox(height: _SPACING),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: _buildImage(images[2]),
                        ),
                        if (images.length > 3)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius:
                                  borderRadius ?? BorderRadius.circular(6),
                              child: Container(
                                color: Color.fromRGBO(0, 0, 0, 0.35),
                                child: Center(
                                    child: Text(
                                  '+${images.length - 3}',
                                  style: context.textTheme.headline2
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  _buildImage(String url) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
      ),
    );
  }
}
