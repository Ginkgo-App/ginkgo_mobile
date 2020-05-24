import 'package:object_mapper/object_mapper.dart';

class MultiSizeImage {
  String _smallSquare = ''; // 90x90
  String _bigSquare = ''; // 160x160
  String _smallThumb = ''; // 160x160
  String _mediumThumb = ''; // 320x320
  String _largeThumb = ''; // 640x640
  String _hugeThumb = ''; // 1024x1024

  String get smallSquare => _smallSquare;

  String get bigSquare => _bigSquare;

  String get smallThumb => _smallThumb;

  String get mediumThumb => _mediumThumb;

  String get largeThumb => _largeThumb;

  String get hugeThumb => _hugeThumb;

  MultiSizeImage(String imgUrl) {
    if (_isImgur(imgUrl)) {
      final imgurLink = 'https://i.imgur.com/';
      String imgurId = imgUrl.split('/').last.split('.').first;
      if (imgurId.length > 7) {
        imgurId = imgurId.substring(0, 7);
      }
      _smallSquare = imgurLink + imgurId + 's.jpg';
      _bigSquare = imgurLink + imgurId + 'b.jpg';
      _smallThumb = imgurLink + imgurId + 't.jpg';
      _mediumThumb = imgurLink + imgurId + 'm.jpg';
      _largeThumb = imgurLink + imgurId + 'l.jpg';
      _hugeThumb = imgurLink + imgurId + 'h.jpg';
    } else {
      _smallSquare = _bigSquare =
          _smallThumb = _mediumThumb = _largeThumb = _hugeThumb = imgUrl;
    }
  }

  bool _isImgur(String imgUrl) => imgUrl.contains('imgur.com');
}

class MultiSizeImageTransform implements Transformable<MultiSizeImage, String> {
  DateUnit unit;
  MultiSizeImageTransform();

  //
  @override
  MultiSizeImage fromJson(value) {
    if (value is String) return MultiSizeImage(value);

    return null;
  }

  @override
  String toJson(MultiSizeImage value) {
    if (value == null) return null;

    return value.hugeThumb;
  }
}
