part of widget;

class AddCommentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Avatar(imageUrl: FakeData.currentUser.avatar.smallThumb),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            Strings.post.addComment,
            style: context.textTheme.subtitle1.copyWith(
              fontStyle: FontStyle.italic,
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
