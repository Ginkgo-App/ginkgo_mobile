import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/models/comment.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/models/post.dart';
import 'package:ginkgo_mobile/src/models/review.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/galleryItem.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:intl/intl.dart';

class CollapsePost extends StatelessWidget {
  final Post post;
  final Review review;
  final Function(Post) onMenuPressed;

  const CollapsePost({Key key, this.post, this.onMenuPressed, this.review})
      : assert((post != null || review != null) &&
            (post == null || review == null)),
        super(key: key);

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
            child: SvgPicture.asset(Assets.icons.activityTypePhotography,
                height: 24),
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
                author: post?.author ?? review.author,
                review: review,
                totalImage: post?.images?.length ?? 0,
              ),
              _buildTime(context, post?.createAt ?? review?.createAt),
              const SizedBox(height: 5),
              if (review != null) _buildRating(context, review.rating),
              HiddenText(post?.content ?? review?.content),
              const SizedBox(height: 5),
              if (post != null) ...[
                GalleryItem(
                  images: post.images,
                  borderRadius: BorderRadius.circular(0),
                ),
                const SizedBox(height: 5)
              ],
              _buildLikeCommentButton(context,
                  totalLike: post?.totalLike ?? review?.totalLike),
              const SizedBox(height: 5),
              _buildCommentList(
                context,
                totalComment: post?.totalComment ?? review.totalComment,
                comments: post?.featuredComments ?? review.featuredComments,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTop(BuildContext context,
      {Review review, int totalImage, @required User author}) {
    final postTitle = totalImage > 1
        ? Strings.post.justPostImages
        : totalImage == 1
            ? Strings.post.justPostAImage
            : Strings.post.justPostAPost;

    return Row(
      children: <Widget>[
        Expanded(
          child: RichText(
            text: TextSpan(
              style:
                  context.textTheme.body1.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: author.displayName,
                ),
                TextSpan(
                  text: review == null ? postTitle : Strings.post.reviewTitle,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                if (review != null) ...[
                  TextSpan(
                    text: review.tourInfo.name,
                  ),
                  TextSpan(
                    text: ' của ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: review.tourInfo.createBy.displayName,
                  ),
                ]
              ],
            ),
          ),
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

  Widget _buildRating(BuildContext context, int rating) {
    return SpacingRow(
      spacing: 2,
      children: <Widget>[
        ...List.generate(
          5,
          (i) => Container(
            width: 25,
            height: 3,
            color:
                rating >= i + 1 ? DesignColor.lightRed : DesignColor.lightLightPink,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$rating/5 điểm',
          style: context.textTheme.overline.copyWith(
            color: DesignColor.darkRed,
            fontWeight: FontWeight.bold,
          ),
        )
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
        Avatar(imageUrl: comment.author.avatar),
        const SizedBox(width: 6),
        Text(
          comment.author.displayName,
          style: context.textTheme.subhead.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onBackground,
          ),
        ),
        Expanded(
          child: Text(
            ' ${comment.content}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.subhead.copyWith(
              color: context.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
