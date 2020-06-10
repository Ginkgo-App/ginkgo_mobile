part of '../widgets.dart';

class CollapseContainer extends StatefulWidget {
  final double collapseHeight;
  final Widget child;
  final Duration duration;
  final String title;
  final bool isCollapsing;
  final Function(bool) onChangeCollapse;

  const CollapseContainer({
    Key key,
    this.collapseHeight,
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.title,
    this.isCollapsing = true,
    this.onChangeCollapse,
  }) : super(key: key);

  @override
  _CollapseContainerState createState() => _CollapseContainerState();
}

class _CollapseContainerState extends State<CollapseContainer>
    with SingleTickerProviderStateMixin {
  final key = GlobalKey();
  final GlobalKey childKey = GlobalKey();
  // CollapseController controller;
  AnimationController animController;
  bool isCollapsing = true;
  double minHeight = 0;

  @override
  void initState() {
    super.initState();
    minHeight = widget.collapseHeight;

    animController =
        AnimationController(vsync: this, duration: widget.duration);
  }

  onChange() {
    if (!isCollapsing) {
      setState(() {
        isCollapsing = true;
        animController.reverse();
        widget.onChangeCollapse?.call(true);
      });
    } else {
      setState(() {
        isCollapsing = false;
        animController.forward();
        widget.onChangeCollapse?.call(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      key: key,
      title: widget.title,
      childPadding: EdgeInsets.zero,
      actions: <Widget>[if (minHeight != null) buildCollapseButton()],
      child: Stack(
        children: <Widget>[
          _SizeTransition(
            axisAlignment: -1,
            minHeight: minHeight,
            sizeFactor: animController,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(key: childKey, child: widget.child),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: AnimatedOpacity(
                duration: widget.duration,
                opacity: isCollapsing && minHeight != null ? 1 : 0,
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
            ),
          )
        ],
      ),
    );
  }

  buildCollapseButton() {
    return GestureDetector(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 0.5).animate(animController),
        child: Icon(Icons.keyboard_arrow_down),
      ),
      onTap: onChange,
    );
  }
}

class _SizeTransition extends AnimatedWidget {
  /// Creates a size transition.
  ///
  /// The [axis], [sizeFactor], and [axisAlignment] arguments must not be null.
  /// The [axis] argument defaults to [Axis.vertical]. The [axisAlignment]
  /// defaults to 0.0, which centers the child along the main axis during the
  /// transition.
  const _SizeTransition({
    this.minHeight,
    Key key,
    this.axis = Axis.vertical,
    @required Animation<double> sizeFactor,
    this.axisAlignment = 1.0,
    this.child,
  })  : assert(axis != null),
        assert(sizeFactor != null),
        assert(axisAlignment != null),
        super(key: key, listenable: sizeFactor);

  /// [Axis.horizontal] if [sizeFactor] modifies the width, otherwise
  /// [Axis.vertical].
  final Axis axis;

  /// The animation that controls the (clipped) size of the child.
  ///
  /// The width or height (depending on the [axis] value) of this widget will be
  /// its intrinsic width or height multiplied by [sizeFactor]'s value at the
  /// current point in the animation.
  ///
  /// If the value of [sizeFactor] is less than one, the child will be clipped
  /// in the appropriate axis.
  Animation<double> get sizeFactor => listenable;

  /// Describes how to align the child along the axis that [sizeFactor] is
  /// modifying.
  ///
  /// A value of -1.0 indicates the top when [axis] is [Axis.vertical], and the
  /// start when [axis] is [Axis.horizontal]. The start is on the left when the
  /// text direction in effect is [TextDirection.ltr] and on the right when it
  /// is [TextDirection.rtl].
  ///
  /// A value of 1.0 indicates the bottom or end, depending upon the [axis].
  ///
  /// A value of 0.0 (the default) indicates the center for either [axis] value.
  final double axisAlignment;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  final double minHeight;

  @override
  Widget build(BuildContext context) {
    AlignmentDirectional alignment;
    if (axis == Axis.vertical)
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    else
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    return ClipRect(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Align(
          alignment: alignment,
          heightFactor: axis == Axis.vertical ? max(sizeFactor.value, 0) : null,
          widthFactor:
              axis == Axis.horizontal ? max(sizeFactor.value, 0.0) : null,
          child: child,
        ),
      ),
    );
  }
}
