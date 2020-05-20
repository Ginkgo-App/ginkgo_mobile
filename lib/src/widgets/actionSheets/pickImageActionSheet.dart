import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:image_picker/image_picker.dart';

pickImage(BuildContext context, Function(File) onPickedImage) async {
  FocusScope.of(context).unfocus();
  showCupertinoModalPopup(
    context: context,
    useRootNavigator: false,
    builder: (context) => CupertinoActionSheet(
      title: null,
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () =>
              ImagePicker.pickImage(source: ImageSource.camera).then((image) {
            onPickedImage(image);
          }).whenComplete(() => Navigator.pop(context)),
          child: Text(
            Strings.button.takeAPicture,
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () =>
              ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
            onPickedImage(image);
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