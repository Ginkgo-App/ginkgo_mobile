part of 'create_post_widgets.dart';

class CreatePostImageList extends StatelessWidget {
  final List<FileAsset> images;
  final Function(FileAsset) onRemovedImage;
  const CreatePostImageList({
    Key key,
    this.images,
    this.onRemovedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SpacingRow(
        spacing: 10,
        isSpacingHeadTale: true,
        children: images
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                CreatePostImage(
                  image: e.file,
                  onCrossIconPressed: () {
                    onRemovedImage?.call(images[i]);
                  },
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
