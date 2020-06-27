library post_widgets;

import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function(Post) onMenuPressed;
  final bool showAuthorAvatar;
  final bool isCollapse;

  const PostWidget({
    Key key,
    this.post,
    this.onMenuPressed,
    this.showAuthorAvatar = false,
    this.isCollapse = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: !showAuthorAvatar
                ? SvgPicture.asset(post.icon, height: 24)
                : AspectRatio(
                    aspectRatio: 1,
                    child: Avatar(
                      imageUrl: post.author.avatar.smallThumb,
                      size: 40,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTop(
                context,
                author: post?.author,
                totalImage: post?.images?.length ?? 0,
              ),
              _buildTime(context, post?.createAt),
              const SizedBox(height: 5),
              if (post.type == PostType.rating) Rating(rating: post.rating),
              isCollapse ? HiddenText(post?.content) : Text(post?.content),
              const SizedBox(height: 5),
              if (post != null) ...[
                GalleryItem(
                  images: post.images ?? [],
                  borderRadius: BorderRadius.circular(0),
                ),
                const SizedBox(height: 5)
              ],
              _buildLikeCommentButton(context, totalLike: post?.totalLike),
              const SizedBox(height: 5),
              _buildCommentList(
                context,
                totalComment: post?.totalComment,
                comments: post?.featuredComments,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTop(BuildContext context,
      {int totalImage, @required User author}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildPostTitle(context, post),
        ),
        CupertinoButton(
          minSize: 0,
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.more_horiz,
            color: context.colorScheme.onBackground,
          ),
          onPressed: () => onMenuPressed?.call(post),
        )
      ],
    );
  }

  Widget _buildPostTitle(BuildContext context, Post post) {
    List<TextSpan> textSpans = [];

    switch (post.type) {
      case PostType.normal:
        textSpans = [
          TextSpan(
            text: post.author.displayName,
          ),
          TextSpan(
            text: Strings.post.justPostAPost,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.image:
        textSpans = [
          TextSpan(
            text: post.author.displayName,
          ),
          TextSpan(
            text: Strings.post.justPostAImage,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.images:
        textSpans = [
          TextSpan(
            text: post.author.displayName,
          ),
          TextSpan(
            text: Strings.post.justPostImages,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.tourJustCreated:
        textSpans = [
          TextSpan(
            text: post.author.displayName,
          ),
          TextSpan(
            text: Strings.post.justCreateATour,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.tourCreated:
        textSpans = [
          TextSpan(
            text: post.author.displayName,
          ),
          TextSpan(
            text: Strings.post.createdATour,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ];
        break;
      case PostType.rating:
        textSpans = [
          TextSpan(
            text: post?.author?.displayName ?? '',
          ),
          TextSpan(
            text: Strings.post.reviewTitle,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          TextSpan(
            text: post?.tour?.name ?? '',
          ),
          TextSpan(
            text: ' của ',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          TextSpan(
            text: post?.tour?.host?.name ?? '',
          ),
        ];
        break;
    }

    return RichText(
      text: TextSpan(
        style:
            context.textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold),
        children: textSpans,
      ),
    );
  }

  Widget _buildTime(BuildContext context, DateTime createAt) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          Assets.icons.datetime,
          color: DesignColor.tinyItems,
          height: 10,
        ),
        const SizedBox(width: 5),
        Text(
          DateFormat('hh:mm dd/MM/yyyy').format(createAt),
          style: TextStyle(fontSize: 10, color: DesignColor.tinyItems),
        ),
      ],
    );
  }

  Widget _buildLikeCommentButton(
    BuildContext context, {
    int totalLike,
    Function onLikePressed,
    Function onCommentPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.only(right: 16),
              child: SvgPicture.asset(Assets.icons.heartOutline, height: 18),
              onPressed: onLikePressed,
            ),
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              child: SvgPicture.asset(Assets.icons.comment, height: 18),
              onPressed: onCommentPressed,
            ),
          ],
        ),
        if (totalLike != null && totalLike > 0) ...[
          const SizedBox(height: 5),
          Text(
            Strings.post.totalLike(totalLike),
            style: TextStyle(
              fontSize: 10,
              color: DesignColor.tinyItems,
            ),
          )
        ]
      ],
    );
  }

  Widget _buildCommentList(BuildContext context,
      {@required int totalComment, @required List<Comment> comments}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          Strings.post.viewAllComment(totalComment),
          style: context.textTheme.overline.copyWith(
            color: DesignColor.tinyItems,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SpacingColumn(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...comments.map((e) => _buildComment(context, e)).toList(),
              AddCommentWidget(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildComment(BuildContext context, Comment comment) {
    return Row(
      children: <Widget>[
        Avatar(imageUrl: comment.author.avatar.smallThumb),
        const SizedBox(width: 6),
        Text(
          comment.author.displayName,
          style: context.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onBackground,
          ),
        ),
        Expanded(
          child: Text(
            ' ${comment.content}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodyText2.copyWith(
              color: context.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
