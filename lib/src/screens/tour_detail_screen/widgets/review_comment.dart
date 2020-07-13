import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class ReviewItem extends StatelessWidget {
  final Post review;

  const ReviewItem({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      enabled: review == null,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: SkeletonItem(
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
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    SkeletonItem(
                      child: Text(
                        review?.author?.displayName ?? '',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SkeletonItem(
                      child: Text(
                        'Ngày ${review?.createAt?.toVietNamese()}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 12),
                      ),
                    ),
                    if (review?.rating != null) ...[
                      const SizedBox(height: 5),
                      Rating(rating: review?.rating),
                    ],
                    const SizedBox(height: 5),
                    SkeletonItem(
                      child: HiddenText(
                        review?.content ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                            fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(height: 1, color: DesignColor.lightestBlack),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
