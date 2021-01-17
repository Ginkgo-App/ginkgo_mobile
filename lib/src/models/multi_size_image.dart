part of 'models.dart';

class MultiSizeImage {
  final _imgurLink = 'https://i.imgur.com/';
  String _imageId = '';
  String _smallSquare = ''; // 90x90
  String _bigSquare = ''; // 160x160
  String _smallThumb = ''; // 160x160
  String _mediumThumb = ''; // 320x320
  String _largeThumb = ''; // 640x640
  String _hugeThumb = ''; // 1024x1024
  String _original = '';

  String get imageId => this?._imageId ?? '';

  String get original => this?._original ?? '';

  String get smallSquare => this?._smallSquare ?? '';

  String get bigSquare => this?._bigSquare ?? '';

  String get smallThumb => this?._smallThumb ?? '';

  String get mediumThumb => this?._mediumThumb ?? '';

  String get largeThumb => this?._largeThumb ?? '';

  String get hugeThumb => this?._hugeThumb ?? '';

  MultiSizeImage(String imgUrl) {
    if (_isImgur(imgUrl)) {
      String imgurId = imgUrl.split('/').last.split('.').first;
      if (imgurId.length > 7) {
        imgurId = imgurId.substring(0, 7);
      }
      _smallSquare = _imgurLink + imgurId + 's.jpg';
      _bigSquare = _imgurLink + imgurId + 'b.jpg';
      _smallThumb = _imgurLink + imgurId + 't.jpg';
      _mediumThumb = _imgurLink + imgurId + 'm.jpg';
      _largeThumb = _imgurLink + imgurId + 'l.jpg';
      _hugeThumb = _imgurLink + imgurId + 'h.jpg';
      _original = _imgurLink + imgurId + '.jpg';
      _imageId = imgurId;
    } else {
      _imageId = _smallSquare = _bigSquare = _smallThumb =
          _mediumThumb = _largeThumb = _hugeThumb = _original = imgUrl;
    }
  }

  bool _isImgur(String imgUrl) => imgUrl.contains('imgur.com');
}
