part of '../widgets.dart';

pickImage(BuildContext context, Function(File) onPickedImage,
    {bool isMulti = false}) async {
  FocusScope.of(context).unfocus();
  showCupertinoModalPopup(
    context: context,
    useRootNavigator: false,
    builder: (context) => CupertinoActionSheet(
      title: null,
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () => ImagePicker.pickImage(source: ImageSource.camera)
              .then((image) async {
            onPickedImage(await _cropImage(context, image));
          }).whenComplete(() => Navigator.pop(context)),
          child: Text(
            Strings.button.takeAPicture,
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () => ImagePicker.pickImage(source: ImageSource.gallery)
              .then((image) async {
            onPickedImage(await _cropImage(context, image));
          }).whenComplete(() => Navigator.pop(context)),
          child: Text(
            Strings.button.pickFromGallery,
          ),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        isDestructiveAction: true,
        child: Text(
          Strings.button.cancel,
        ),
      ),
    ),
  );
}

Future<List<FileAsset>> pickMultiImage(
    BuildContext context, List<FileAsset> selectedAssets,
    {int maxImages = 4}) async {
  final assets = await MultiImagePicker.pickImages(
    maxImages: maxImages,
    enableCamera: true,
    selectedAssets: selectedAssets.map((e) => e.asset).toList(),
    materialOptions: MaterialOptions(
      actionBarColor: context.colorScheme.primary.toHex(),
      startInAllView: true,
      lightStatusBar: true,
    ),
    cupertinoOptions: CupertinoOptions(
        selectionFillColor: context.colorScheme.primary.toHex(),
        selectionCharacter: "✓",
        selectionStrokeColor: context.colorScheme.primary.toHex(),
        backgroundColor: context.colorScheme.primary.toHex()),
  );

  return await Future.wait(assets.map((e) => FileAsset.fromAsset(e)).toList());
}

Future<File> _cropImage(BuildContext context, File image) async {
  return await ImageCropper.cropImage(
    sourcePath: image.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio5x4,
    ],
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: 'Cắt ảnh',
      toolbarColor: context.colorScheme.primary,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: true,
    ),
    iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: true,
        aspectRatioPickerButtonHidden: true,
        aspectRatioLockDimensionSwapEnabled: true,
        resetButtonHidden: true),
  );
}
