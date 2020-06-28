part of '../widgets.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key key, @required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.background,
            border: Border(
              bottom: BorderSide(width: 0.5, color: DesignColor.darkestWhite),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
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
                        imageUrl: comment?.author?.avatar?.smallSquare ?? '',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SkeletonItem(
                            child: Text(
                              (comment?.author?.displayName ?? '') + ' • ',
                              style: context.textTheme.bodyText1
                                  .copyWith(color: colorScheme.onSurface),
                            ),
                          ),
                          if (comment == null) const SizedBox(height: 5),
                          SkeletonItem(
                            child: Text(
                              comment?.createAt != null
                                  ? timeAgo.format(comment.createAt,
                                      locale: 'vi')
                                  : '',
                              style: context.textTheme.bodyText2
                                  .copyWith(color: colorScheme.onSurface),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SkeletonItem(
                        child: Text(
                          comment?.content ?? '',
                          style: context.textTheme.bodyText2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
