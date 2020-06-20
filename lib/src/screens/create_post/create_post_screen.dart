part of '../screens.dart';

class CreatePostScreenArgs {
  final Post post;
  final Comment comment;
  final Tour tour;

  CreatePostScreenArgs({this.post, this.comment, this.tour})
      : assert(post != null && comment == null && tour == null ||
            comment != null && post == null && tour == null ||
            tour != null && comment == null && post == null);
}

class CreatePostScreen extends StatefulWidget {
  final CreatePostScreenArgs args;

  CreatePostScreen({Key key, this.args}) : super(key: key);

  _ComposeTweetReplyPageState createState() => _ComposeTweetReplyPageState();
}

class _ComposeTweetReplyPageState extends State<CreatePostScreen> {
  final PostCommentBloc _postCommentBloc = PostCommentBloc();
  CreatePostScreenArgs _args;
  ScrollController _scrollcontroller;
  List<FileAsset> _images = [];
  int _rating;

  TextEditingController _contentController;

  bool get _isReply =>
      _args != null && (_args.comment != null || _args.post != null);

  @override
  void initState() {
    _scrollcontroller = ScrollController();
    _contentController = TextEditingController();
    _args = widget.args;
    super.initState();
  }

  void _onSubmit() {
    if (!_isReply) {
      final postToPost = PostToPost(
        content: _contentController.text,
        images: _images.map((e) => e.file).toList(),
        tourId: _args.tour?.id,
        rating: _rating,
      );

      _postCommentBloc.add(PostCommentEventCreatePost(postToPost));
    } else {
      final commentToPost = CommentToPost(
        _args.post?.id ?? _args.comment?.id,
        content: _contentController.text,
      );

      _postCommentBloc.add(PostCommentEventCreateComment(commentToPost));
    }
  }

  void _onImageIconSelected(List<FileAsset> files) {
    if (files != null) {
      setState(() {
        _images = [...files];
      });
    }
  }

  String _getTextFieldPlaceholder() {
    if (_isReply) {
      if (_args.tour != null) {
        return 'Nhận xét chuyến đi';
      } else if (_args.post != null) {
        return 'Nhập bình luận';
      } else {
        return 'Nhập bình luận';
      }
    } else {
      return 'Hôm nay bạn thế nào?';
    }
  }

  _ReplyData _getReplyData() {
    if (_isReply) {
      if (_args.tour != null) {
        return _ReplyData(
            image: _args.tour.images != null && _args.tour.images.length > 0
                ? _args.tour.images[0].smallSquare
                : '',
            content:
                '${_args.tour.tourInfo?.startPlace?.name} - ${_args.tour.tourInfo?.destinatePlace?.name}',
            replyText: 'Đánh giá chuyến đi ${_args.tour.name}',
            timeText: '${_args.tour.startDay.toVietNamese()}',
            title: _args.tour.name,
            rating: _rating,
            onRatingChanged: (i) {
              setState(() {
                _rating = i.round();
              });
            });
      } else if (_args.post != null) {
        return _ReplyData(
          image: _args.post.author?.avatar?.smallSquare,
          content: _args.post.content,
          replyText: 'Bình luận ${_args.post.author?.displayName}',
          timeText: '${_args.post.createAt.toVietNamese()}',
          title: _args.post.author?.displayName,
        );
      } else {
        return _ReplyData(
          image: _args.comment.author?.avatar?.smallSquare,
          content: _args.comment.content,
          replyText: 'Bình luận ${_args.comment.author?.displayName}',
          timeText: '${_args.comment.createAt.toVietNamese()}',
          title: _args.comment.author?.displayName,
        );
      }
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    _contentController.dispose();
    _postCommentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _postCommentBloc,
      listener: (context, state) {
        if (state is PostCommentStatePostSuccess) {
          showErrorMessage('Thành công');
          Navigator.pop(context);
        } else if (state is PostCommentStateFailure) {
          showErrorMessage(Strings.error.error + '\n' + state.error.toString());
        }
      },
      child: BlocBuilder(
        bloc: _postCommentBloc,
        builder: (context, state) {
          return PrimaryScaffold(
            isLoading: state is PostCommentStateLoading,
            appBar: CustomAppBar(
              onActionPressed: _onSubmit,
              isCrossButton: true,
              submitButtonText: 'Đăng',
              isSubmitDisable: false,
              isbootomLine: true,
            ),
            backgroundColor: context.colorScheme.background,
            body: Container(
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    controller: _scrollcontroller,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          if (_isReply) _ReplyCard(data: _getReplyData()),
                          _CreatePost(
                            textFieldPlaceholder: _getTextFieldPlaceholder(),
                          ),
                          Flexible(
                            child: CreatePostImageList(
                              images: _images,
                              onRemovedImage: (image) {
                                setState(() {
                                  _images.remove(image);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ComposeBottomIconWidget(
                      textEditingController: _contentController,
                      onImageIconSelected: _onImageIconSelected,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReplyData {
  final String content;
  final String replyText;
  final String timeText;
  final String image;
  final String title;
  final int rating;
  final Function(double) onRatingChanged;

  _ReplyData({
    this.content,
    this.replyText,
    this.timeText,
    this.image,
    this.title,
    this.rating,
    this.onRatingChanged,
  });
}

class _ReplyCard extends StatelessWidget {
  final _ReplyData data;

  const _ReplyCard({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              customImage(context, data?.image ?? '', height: 40),
              Expanded(
                child: Container(width: 2, color: context.colorScheme.surface),
              )
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: TitleText(data?.title ?? '',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(width: 5),
                    if (data?.timeText != null)
                      customText('- ${data.timeText}',
                          style: context.textTheme.caption)
                  ],
                ),
                UrlText(
                  text: data?.content ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  urlStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),
                if (data?.replyText != null)
                  UrlText(
                    text: data?.replyText,
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 13,
                    ),
                  ),
                if (data?.onRatingChanged != null) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(right: 50),
                      child: StarRating(
                        allowHalfRating: false,
                        filledIconData: Icons.favorite,
                        defaultIconData: Icons.favorite_border,
                        borderColor: context.colorScheme.primary,
                        color: context.colorScheme.primary,
                        starCount: 5,
                        rating: 3,
                        onRatingChanged: data.onRatingChanged,
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CreatePost extends StatelessWidget {
  const _CreatePost({Key key, this.textFieldPlaceholder = ''})
      : super(key: key);

  final String textFieldPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: customImage(
            context,
            CurrentUserBloc().currentUser?.avatar?.mediumThumb ?? '',
            height: 40,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TextField(placeholder: textFieldPlaceholder),
        )
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key key,
    this.textEditingController,
    this.placeholder = '',
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: textEditingController,
          onChanged: (text) {},
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: placeholder,
            hintStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('placeholder', placeholder));
  }
}
