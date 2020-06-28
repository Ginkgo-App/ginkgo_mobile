part of widget;

class AddCommentWidget extends StatelessWidget {
  final String avatar;

  const AddCommentWidget({Key key, @required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Avatar(imageUrl: avatar ?? ''),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            Strings.post.addComment,
            style: context.textTheme.bodyText2.copyWith(
              fontStyle: FontStyle.italic,
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
