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
  bool isCollapsing;
  AnimationController _controller;
  final GlobalKey childKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    isCollapsing = widget.isCollapsing;
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      title: widget.title,
      childPadding: EdgeInsets.zero,
      actions: <Widget>[if (widget.height != null) buildCollapseButton()],
      child: AnimatedContainer(
        duration: widget.duration,
        height: !isCollapsing || widget.height == null
            ? (childKey.currentContext?.findRenderObject() as RenderBox)
                    ?.size
                    ?.height ??
                null
            : widget.height,
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
                opacity: isCollapsing && widget.height != null ? 1 : 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: GradientColor.of(context).whiteBottomGradient),
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
