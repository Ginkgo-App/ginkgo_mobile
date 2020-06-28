part of widget;

class AddCommentWidget extends StatelessWidget {
  final String avatar;
  final Function onPressed;

  const AddCommentWidget({Key key, @required this.avatar, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
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
      ),
    );
  }
}
