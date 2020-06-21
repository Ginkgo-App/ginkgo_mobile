part of '../widgets.dart';

class PhotoViewDescription {}

class PhotoViewDialog {
  final BuildContext context;
  final List<MultiSizeImage> images;
  final List<PhotoViewDescription> descriptions;

  PhotoViewDialog(
    this.context, {
    @required this.images,
    this.descriptions,
  });

  Future show() {
    return showDialog(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return _PhotoView(images: images);
        });
  }
}

class _PhotoView extends StatefulWidget {
  final List<MultiSizeImage> images;

  const _PhotoView({Key key, this.images = const []}) : super(key: key);

  @override
  __PhotoViewState createState() => __PhotoViewState();
}

class __PhotoViewState extends State<_PhotoView> {
  int currentPage = 0;
  
  _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBack(context),
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: Stack(children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: widget.images.length,
            onPageChanged: (i) {

            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.images[index].hugeThumb),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.contained * 5,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.images[index].imageId),
              );
            },
            loadingBuilder: (context, event) {
              return LoadingIndicator();
            },
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black87,

            ),
          ),
          Positioned(
            top: 12,
            left: 14,
            child: SafeArea(
              child: CupertinoButton(
                pressedOpacity: 0.7,
                padding: EdgeInsets.all(0),
                onPressed: () => _onBack(context),
                child: Icon(
                  Icons.close,
                  color: context.colorScheme.background,
                  size: 30,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
