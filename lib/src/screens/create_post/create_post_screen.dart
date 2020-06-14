part of '../screens.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key key, this.isTweet = true}) : super(key: key);

  final bool isTweet;
  _ComposeTweetReplyPageState createState() => _ComposeTweetReplyPageState();
}

class _ComposeTweetReplyPageState extends State<CreatePostScreen> {
  bool isScrollingDown = false;
  ScrollController scrollcontroller;
  List<FileAsset> _images = [];

  TextEditingController _textEditingController;

  @override
  void dispose() {
    scrollcontroller.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollcontroller = ScrollController();
    _textEditingController = TextEditingController();
    super.initState();
  }

  void _onImageIconSelected(List<FileAsset> files) {
    if (files != null) {
      setState(() {
        _images = [...files];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'HelveticaNeue',
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
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
              child: _ComposeTweet(
                images: _images,
                onRemovedImage: (image) {
                  setState(() {
                    _images.remove(image);
                  });
                },
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

class _ComposeTweet extends StatelessWidget {
  final List<FileAsset> images;
  final Function(FileAsset) onRemovedImage;

  const _ComposeTweet({Key key, this.images, this.onRemovedImage})
      : super(key: key);

  Widget _tweerCard(BuildContext context) {
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
                      text: 'Comment content',
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
                  UrlText(
                    text: 'Trả lời ${FakeData.currentUser.displayName}',
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
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: customText(
                      '- ${'getChatTime(viewState.model.createdAt)'}',
                      style: context.textTheme.caption),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _tweerCard(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              customImage(context, FakeData.currentUser.avatar.smallThumb,
                  height: 40),
              const SizedBox(width: 10),
              Expanded(
                child: _TextField(isTweet: false),
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
  const _TextField(
      {Key key,
      this.textEditingController,
      this.isTweet = false,
      this.isRetweet = false})
      : super(key: key);
  final TextEditingController textEditingController;
  final bool isTweet;
  final bool isRetweet;

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
              hintText: isTweet
                  ? 'What\'s happening?'
                  : isRetweet ? 'Add a comment' : 'Tweet your reply',
              hintStyle: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
