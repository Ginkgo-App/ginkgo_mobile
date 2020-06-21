import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'dot_indicator.dart';
import 'package:base/base.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<String> imageUrls;
  final BorderRadius imageBorderRadius;
  final double imageHeight;
  final EdgeInsets padding;
  final Color dotColor;
  final bool showDot;
  final bool showButton;

  const ImageSliderWidget({
    Key key,
    @required this.imageUrls,
    @required this.imageBorderRadius,
    this.imageHeight = 350.0,
    this.padding = const EdgeInsets.all(8.0),
    this.dotColor = Colors.red,
    this.showDot = true,
    this.showButton = false,
  }) : super(key: key);

  @override
  ImageSliderWidgetState createState() {
    return new ImageSliderWidgetState();
  }
}

class ImageSliderWidgetState extends State<ImageSliderWidget> {
  List<Widget> _pages = [];

  int page = 0;

  final _controller = PageController();

  Timer timer;

  @override
  void initState() {
    super.initState();
    _pages = widget.imageUrls.map((url) {
      return _buildImagePageItem(url);
    }).toList();

    timer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        page = page == _pages.length - 1 ? page = 0 : page + 1;
        _controller.animateToPage(page,
            duration: Duration(milliseconds: 1000), curve: Curves.easeOutQuint);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildingImageSlider();
  }

  Widget _buildingImageSlider() {
    return Container(
      height: 200.0,
      padding: widget.padding,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.zero,
        elevation: 4.0,
        child: Stack(
          children: [
            _buildPagerViewSlider(),
            if (widget.showDot) _buildDotsIndicatorOverlay(),
            if (widget.showButton) ...[
              _buildButtonLeftIndicatorOverlay(),
              _buildButtonRightIndicatorOverlay()
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildPagerViewSlider() {
    return Positioned.fill(
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index % _pages.length];
        },
        onPageChanged: (int p) {
          setState(() {
            page = p;
          });
        },
      ),
    );
  }

  Positioned _buildDotsIndicatorOverlay() {
    return Positioned(
      bottom: 5.0,
      left: 0.0,
      right: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DotsIndicator(
          controller: _controller,
          itemCount: _pages.length,
          color: widget.dotColor,
          onPageSelected: (int page) {
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }

  Widget _buildButtonLeftIndicatorOverlay() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          child: Icon(Icons.chevron_left),
          color: DesignColor.tinyItems,
          borderRadius: BorderRadius.circular(90),
          onPressed: () {
            _controller.previousPage(
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          },
        ),
      ),
    );
  }

  Widget _buildButtonRightIndicatorOverlay() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          child: Icon(Icons.chevron_right),
          color: DesignColor.tinyItems,
          borderRadius: BorderRadius.circular(90),
          onPressed: () {
            _controller.nextPage(
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          },
        ),
      ),
    );
  }

  Widget _buildImagePageItem(String imgUrl) {
    return ClipRRect(
      borderRadius: widget.imageBorderRadius,
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        placeholder: (context, url) => Center(
          child: LoadingIndicator(color: context.colorScheme.primary),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
