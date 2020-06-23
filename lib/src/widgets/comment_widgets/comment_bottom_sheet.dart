part of '../widgets.dart';

class CommentBottomSheet {
  final BuildContext context;
  final int postId;

  CommentBottomSheet(this.context, {@required this.postId})
      : assert(postId != null);

  Future show() async {
    return showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        snapSpec: SnapSpec(snappings: [0.9]),
        cornerRadius: 10,
        builder: (context, state) {
          return Column(
            children: _buildListReviewComment(
              List.generate(
                10,
                (index) => Comment(
                  id: 12,
                  postId: '1',
                  author: FakeData.currentUser,
                  content: 'Ôi ảnh đẹp quá bạn ơi...',
                  createAt: DateTime.now().subtract(Duration(days: 3)),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  List<Widget> _buildListReviewComment(List<Comment> comments) {
    return comments
        .asMap()
        .map((index, value) {
          if (index == 0)
            return MapEntry(
                index,
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    CommentItem(
                      comment: comments[index],
                    ),
                  ],
                ));
          return MapEntry(
              index,
              CommentItem(
                comment: comments[index],
              ));
        })
        .values
        .toList();
  }
}
