import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/rating.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ReviewComment extends StatelessWidget {
  final Post review = FakeData.review;

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
        title: 'Nhận xét từ những người đã tham gia trước đó',
        flutterIcon: Assets.icons.downArrow,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildReviewCommentItem(review),
              _buildReviewCommentItem(review),
            ],
          ),
        ));
  }

  Widget _buildReviewCommentItem(Post review) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Container(
                width: 50,
                height: 50,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: review?.author?.avatar?.mediumThumb ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, _) {
                      return Image.asset(
                        Assets.images.defaultAvatar,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text(
                  review.author.fullName ?? 'Cu đơ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  review.createAt.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                      fontSize: 12),
                ),
                const SizedBox(
                  height: 5,
                ),
                Rating(
                  rating: 4,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  review.content,
                  maxLines: 20,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                      fontSize: 12),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black87))),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
