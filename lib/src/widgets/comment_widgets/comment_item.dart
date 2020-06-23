part of '../widgets.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key key, @required this.comment})
      : assert(comment != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: DesignColor.darkestWhite),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: 50.0,
                height: 50.0,
                child: ClipOval(
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      'assets/images/default-avatar.jpg',
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                    imageUrl: comment.author.avatar.smallSquare,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        comment.author.displayName + ' • ',
                        style: context.textTheme.bodyText1
                            .copyWith(color: colorScheme.onSurface),
                      ),
                      Text(
                        timeAgo.format(comment.createAt, locale: 'vi'),
                        style: context.textTheme.bodyText2
                            .copyWith(color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    comment.content,
                    style: context.textTheme.bodyText2.copyWith(
                      color: colorScheme.onBackground,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
