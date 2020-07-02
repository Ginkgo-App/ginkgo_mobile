part of 'models.dart';

enum PostType { normal, image, images, tourJustCreated, tourCreated, rating }

class Post with Mappable {
  int id;
  SimpleUser author;
  DateTime createAt;
  String content;
  List<MultiSizeImage> images;
  int totalLike;
  int totalComment;
  Comment featuredComment;
  double rating;
  SimpleTour tour;
  bool isLiked;

  PostType get type {
    if (rating != null && tour != null) {
      return PostType.rating;
    } else if (tour != null) {
      if (createAt.difference(DateTime.now()).inMinutes < 1) {
        return PostType.tourJustCreated;
      } else {
        return PostType.tourCreated;
      }
    } else if (images != null && images.length > 1) {
      return PostType.images;
    } else if (images != null && images.length == 1) {
      return PostType.image;
    }

    return PostType.normal;
  }

  String get icon {
    if (type == PostType.image || type == PostType.images) {
      return Assets.icons.activityTypePhotography;
    } else if (type == PostType.rating) {
      return Assets.icons.activityTypeReview;
    }
    return Assets.icons.activityTypePost;
  }

  Post({
    this.id,
    this.author,
    this.createAt,
    this.content,
    this.images,
    this.totalLike,
    this.totalComment,
    this.featuredComment,
    this.rating,
    this.tour,
    this.isLiked,
  });

  @override
  void mapping(Mapper map) {
    map('Id', id, (v) => id = v);
    map('Author', author,
        (v) => author = Mapper.fromJson(v).toObject<SimpleUser>());
    map('Content', content, (v) => content = v);
    map<MultiSizeImage>(
        'Images', images, (v) => images = v, MultiSizeImageTransform());
    map('TotalLike', totalLike, (v) => totalLike = v);
    map('TotalComment', totalComment, (v) => totalComment = v);
    map(
        'FeaturedComment',
        featuredComment,
        (v) => featuredComment =
            v != null ? Mapper.fromJson(v).toObject<Comment>() : v);
    map('CreateAt', createAt, (v) => createAt = v, DateTimeTransform());
    map('Rating', rating, (v) => rating = v);
    map('Tour', tour, (v) {
      try {
        tour = v != null ? Mapper.fromJson(v).toObject<SimpleTour>() : v;
      } catch (e) {
        debugPrint(e.toString());
        tour = null;
      }
    });
    map('IsLike', isLiked, (v) => isLiked = v);
  }
}

class PostToPost {
  final String content;
  final List<File> images;
  final int tourId;
  final int rating;

  PostToPost({
    @required this.content,
    this.images = const [],
    this.tourId,
    this.rating,
  });
}
