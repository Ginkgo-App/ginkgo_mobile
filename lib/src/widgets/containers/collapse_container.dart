part of '../widgets.dart';

class CollapseContainer extends StatefulWidget {
  final double height;
  final Widget child;
  final bool isCollapsing;
  final Duration duration;
  final String title;

  const CollapseContainer(
      {Key key,
      this.height,
      this.child,
      this.isCollapsing = true,
      this.duration = const Duration(milliseconds: 500),
      this.title})
      : super(key: key);

  @override
  _CollapseContainerState createState() => _CollapseContainerState();
}

class _CollapseContainerState extends State<CollapseContainer>
    with SingleTickerProviderStateMixin {
  final key = GlobalKey();
  final GlobalKey childKey = GlobalKey();
  bool isCollapsing;
  AnimationController _controller;
  double widgetHeight;

  @override
  void initState() {
    super.initState();
    isCollapsing = widget.isCollapsing;
    widgetHeight = widget.height;
    _controller = AnimationController(vsync: this, duration: widget.duration);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed = key.currentContext.findRenderObject();
      if (renderBoxRed.size.height < widget.height) {
        setState(() {
          widgetHeight = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      key: key,
      title: widget.title,
      childPadding: EdgeInsets.zero,
      actions: <Widget>[if (widgetHeight != null) buildCollapseButton()],
      child: AnimatedContainer(
        duration: widget.duration,
        height: !isCollapsing || widgetHeight == null
            ? (childKey.currentContext?.findRenderObject() as RenderBox)
                    ?.size
                    ?.height ??
                null
            : widgetHeight,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(key: childKey, child: widget.child),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: widget.duration,
                opacity: isCollapsing && widgetHeight != null ? 1 : 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: GradientColor.of(context).whiteBottomGradient,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildCollapseButton() {
    return GestureDetector(
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
          child: Icon(Icons.keyboard_arrow_down),
        ),
        onTap: () {
          if (isCollapsing) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          setState(() {
            isCollapsing = !isCollapsing;
          });
        });
  }
}
