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
  CreatePostScreenArgs args;
  ScrollController scrollcontroller;
  List<FileAsset> _images = [];

  TextEditingController _textEditingController;

  bool get isReply => args != null;

  @override
  void initState() {
    scrollcontroller = ScrollController();
    _textEditingController = TextEditingController();
    args = widget.args;
    super.initState();
  }

  void _onImageIconSelected(List<FileAsset> files) {
    if (files != null) {
      setState(() {
        _images = [...files];
      });
    }
  }

  String _getTextFieldPlaceholder() {
    if (isReply) {
      if (args.tour != null) {
        return 'Nhận xét chuyến đi';
      } else if (args.post != null) {
        return 'Nhập bình luận';
      } else {
        return 'Nhập bình luận';
      }
    } else {
      return 'Hôm nay bạn thế nào?';
    }
  }

  _ReplyData _getReplyData() {
    if (isReply) {
      if (args.tour != null) {
        return _ReplyData(
          image: args.tour.images != null && args.tour.images.length > 0
              ? args.tour.images[0].smallSquare
              : '',
          content:
              '${args.tour.tourInfo?.startPlace?.name} - ${args.tour.tourInfo?.destinatePlace?.name}',
          replyText: 'Nhận xét chuyến đi ${args.tour.name}',
          timeText: '${args.tour.startDay.toVietNamese()}',
          title: args.tour.name,
        );
      } else if (args.post != null) {
        return _ReplyData(
          image: args.post.author?.avatar?.smallSquare,
          content: args.post.content,
          replyText: 'Bình luận ${args.post.author?.displayName}',
          timeText: '${args.post.createAt.toVietNamese()}',
          title: args.post.author?.displayName,
        );
      } else {
        return _ReplyData(
          image: args.comment.author?.avatar?.smallSquare,
          content: args.comment.content,
          replyText: 'Bình luận ${args.comment.author?.displayName}',
          timeText: '${args.comment.createAt.toVietNamese()}',
          title: args.comment.author?.displayName,
        );
      }
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionPressed: () {},
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
              controller: scrollcontroller,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (isReply)
                      _ReplyCard(
                        data: _getReplyData(),
                      ),
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
                textEditingController: _textEditingController,
                onImageIconSelected: _onImageIconSelected,
              ),
            ),
          ],
        ),
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

  _ReplyData(
      {this.content, this.replyText, this.timeText, this.image, this.title});
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30),
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 3),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 2.0,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 72,
                    child: UrlText(
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                customImage(context, data?.image ?? '', height: 40),
                SizedBox(width: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: MediaQuery.of(context).size.width * .5),
                  child: TitleText(data?.title ?? '',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(width: 5),
                if (data?.timeText != null)
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: customText('- ${data.timeText}',
                        style: context.textTheme.caption),
                  )
              ],
            ),
          ],
        ),
      ],
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
        customImage(context, FakeData.currentUser.avatar.smallThumb,
            height: 40),
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
              hintStyle: TextStyle(fontSize: 18)),
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
