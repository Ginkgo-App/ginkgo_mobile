part of 'models.dart';


class FileAsset {
  File _file;
  Asset _asset;

  File get file => _file;
  Asset get asset => _asset;

  static Future<FileAsset> fromAsset(Asset asset) async {
    final FileAsset fileAsset = FileAsset();
    fileAsset._asset = asset;
    fileAsset._file = await _getImageFileFromAssets(asset);

    return fileAsset;
  }
}

Future<File> _getImageFileFromAssets(Asset asset) async {
  final data = await asset.getByteData();

  final file = File('${(await getTemporaryDirectory()).path}/${asset.name}');
  await file.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

  return file;
}
