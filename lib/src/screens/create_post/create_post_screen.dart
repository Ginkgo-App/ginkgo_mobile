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

  String _getReplyText() {
    if (isReply) {
      if (args.tour != null) {
        return 'Nhận xét chuyến đi ${args.tour.name}';
      } else if (args.post != null) {
        return 'Bình luận ${args.post.author?.displayName}';
      } else {
        return 'Nhập bình luận ${args.comment.author?.displayName}';
      }
    } else {
      return '';
    }
  }

  String _getReplyContent() {
    if (isReply) {
      if (args.tour != null) {
        return '${args.tour.tourInfo?.startPlace?.name} - ${args.tour.tourInfo?.destinatePlace?.name}';
      } else if (args.post != null) {
        return args.post.content;
      } else {
        return args.comment.content;
      }
    } else {
      return '';
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
              child: Column(
                children: <Widget>[
                  _ReplyCard(
                    content: _getReplyContent(),
                    replyText: _getReplyText(),
                    timeText: 'time difference',
                  ),
                  _CreatePost(
                    images: _images,
                    textFieldPlaceholder: _getTextFieldPlaceholder(),
                    onRemovedImage: (image) {
                      setState(() {
                        _images.remove(image);
                      });
                    },
                  ),
                ],
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

class _ReplyCard extends StatelessWidget {
  final String content;
  final String replyText;
  final String timeText;

  const _ReplyCard({Key key, this.content, this.replyText, this.timeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: content ?? '',
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
                  if (replyText != null)
                    UrlText(
                      text: replyText,
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
                customImage(context, FakeData.currentUser.avatar.smallThumb,
                    height: 40),
                SizedBox(width: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 0,
                      maxWidth: MediaQuery.of(context).size.width * .5),
                  child: TitleText(FakeData.currentUser.displayName,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(width: 5),
                if (timeText != null)
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: customText('- $timeText',
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
  const _CreatePost(
      {Key key,
      this.images,
      this.onRemovedImage,
      this.textFieldPlaceholder = ''})
      : super(key: key);

  final List<FileAsset> images;
  final Function(FileAsset) onRemovedImage;
  final String textFieldPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ReplyCard(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              customImage(context, FakeData.currentUser.avatar.smallThumb,
                  height: 40),
              const SizedBox(width: 10),
              Expanded(
                child: _TextField(placeholder: textFieldPlaceholder),
              )
            ],
          ),
          Flexible(
            child: CreatePostImageList(
              images: images,
              onRemovedImage: onRemovedImage,
            ),
          ),
        ],
      ),
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
