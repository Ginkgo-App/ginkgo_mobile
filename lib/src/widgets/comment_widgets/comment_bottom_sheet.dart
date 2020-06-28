part of '../widgets.dart';

class CommentBottomSheet {
  final BuildContext context;
  final int postId;
  final int totalLike;
  final bool autoFocusInput;

  CommentBottomSheet(
    this.context, {
    @required this.postId,
    @required this.totalLike,
    this.autoFocusInput = false,
  }) : assert(postId != null);

  Future show() async {
    final PostCommentBloc postCommentBloc = PostCommentBloc();
    final TextEditingController inputController = TextEditingController();

    await showSlidingBottomSheet(
      context,
      useRootNavigator: true,
      builder: (context) {
        return SlidingSheetDialog(
          snapSpec: SnapSpec(snappings: [0.9]),
          cornerRadius: 10,
          color: context.colorScheme.background,
          headerBuilder: (context, state) {
            return totalLike == null
                ? SizedBox.shrink()
                : Material(
                    color: context.colorScheme.background,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: context.colorScheme.surface),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SpacingRow(
                          spacing: 10,
                          children: <Widget>[
                            Icon(Icons.favorite,
                                color: context.colorScheme.primary),
                            Text(
                              '$totalLike người yêu thích',
                              style: context.textTheme.subtitle1.copyWith(
                                  color: DesignColor.blockHeader,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          footerBuilder: (context, state) {
            return Material(
              child: TextField(
                controller: inputController,
                autofocus: autoFocusInput,
                style: context.textTheme.bodyText2,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: Strings.post.addComment,
                  suffixIcon: IconButton(
                    onPressed: state is PostCommentStateLoading ? null : () {},
                    icon: state is PostCommentStateLoading
                        ? CircularProgressIndicator()
                        : Icon(
                            Icons.send,
                            color: context.colorScheme.primary,
                          ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Avatar(
                      imageUrl:
                          CurrentUserBloc().currentUser?.avatar?.smallSquare ??
                              '',
                      size: 30,
                    ),
                  ),
                ),
              ),
            );
          },
          builder: (context, state) {
            return Column(
              children: _buildListReviewComment(
                List.generate(
                  10,
                  (index) => Comment(
                    id: 12,
                    author: FakeData.currentUser,
                    content: 'Ôi ảnh đẹp quá bạn ơi...',
                    createAt: DateTime.now().subtract(Duration(days: 3)),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    postCommentBloc.close();
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
