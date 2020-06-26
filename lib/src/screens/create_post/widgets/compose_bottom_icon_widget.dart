part of 'create_post_widgets.dart';

class ComposeBottomIconWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function(List<FileAsset>) onImageIconSelected;
  ComposeBottomIconWidget(
      {Key key, this.textEditingController, this.onImageIconSelected})
      : super(key: key);

  @override
  _ComposeBottomIconWidgetState createState() =>
      _ComposeBottomIconWidgetState();
}

class _ComposeBottomIconWidgetState extends State<ComposeBottomIconWidget> {
  bool reachToWarning = false;
  bool reachToOver = false;
  Color wordCountColor;
  String tweet = '';
  List<FileAsset> _images = [];

  @override
  void initState() {
    wordCountColor = Colors.blue;
    widget.textEditingController.addListener(updateUI);
    super.initState();
  }

  void updateUI() {
    setState(() {
      tweet = widget.textEditingController.text;
      if (widget.textEditingController.text != null &&
          widget.textEditingController.text.isNotEmpty) {
        if (widget.textEditingController.text.length > 259 &&
            widget.textEditingController.text.length < 280) {
          wordCountColor = Colors.orange;
        } else if (widget.textEditingController.text.length >= 280) {
          wordCountColor = Theme.of(context).errorColor;
        } else {
          wordCountColor = Colors.blue;
        }
      }
    });
  }

  Widget _bottomIconWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          color: context.colorScheme.background),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: pickImage,
            icon: Icon(
              Icons.image,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  void pickImage() {
    pickMultiImage(context, _images).then((List<FileAsset> files) {
      setState(() {
        _images = files;
      });
      widget.onImageIconSelected?.call(_images);
    });
  }

  double getTweetLimit() {
    if (tweet == null || tweet.isEmpty) {
      return 0.0;
    }
    if (tweet.length > 280) {
      return 1.0;
    }
    var length = tweet.length;
    var val = length * 100 / 28000.0;
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _bottomIconWidget(),
    );
  }
}
