part of '../widgets.dart';

// class ListCollappseController extends InheritedWidget {
//   List<CollapseController> _controllers = [];

//   ListCollappseController({Widget child}) : super(child: child);

//   addChild(CollapseController controller) {
//     _controllers.add(controller);
//   }

//   collapseAll() {
//     _controllers.where((e) => !e.isCollapsing).forEach((e) => e.collapse());
//   }

//   static ListCollappseController of(BuildContext context) => context
//       .dependOnInheritedWidgetOfExactType(aspect: ListCollappseController);

//   @override
//   bool updateShouldNotify(InheritedWidget oldWidget) => true;
// }

class CollapseController extends ChangeNotifier {
  bool _isCollapsing = true;

  bool get isCollapsing => _isCollapsing;

  CollapseController({bool isCollapsing = true}) {
    _isCollapsing = isCollapsing;
  }

  open() {
    _isCollapsing = false;
    notifyListeners();
  }

  collapse() {
    _isCollapsing = true;
    notifyListeners();
  }
}

class CollapseContainer extends StatefulWidget {
  final double collapseHeight;
  final Widget child;
  final CollapseController controller;
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
    this.controller,
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
  double currentHeight = 0;
  double minHeight = 0;
  double maxHeight = 0;

  @override
  void initState() {
    super.initState();
    minHeight = widget.collapseHeight;

    // controller = widget.controller ?? CollapseController();
    animController =
        AnimationController(vsync: this, duration: widget.duration);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed = childKey.currentContext.findRenderObject();
      setState(() {
        maxHeight = renderBoxRed.size.height;
        if (renderBoxRed.size.height < minHeight) {
          minHeight = null;
        }

        if (minHeight == null) {
          currentHeight = maxHeight;
        } else {
          if (widget.isCollapsing) {
            currentHeight = minHeight;
          } else {
            currentHeight = maxHeight;
          }
        }
      });

      // controller.addListener(() {
      //   if (controller.isCollapsing && currentHeight != minHeight) {
      //     setState(() {
      //       currentHeight = minHeight;
      //       animController.reverse();
      //     });
      //   } else if (!controller.isCollapsing && currentHeight != maxHeight) {
      //     setState(() {
      //       currentHeight = maxHeight;
      //       animController.forward();s
      //     });
      //   }
      // });
    });
  }

  didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isCollapsing && currentHeight == maxHeight ||
        !widget.isCollapsing && currentHeight == minHeight) {
      if (currentHeight != minHeight) {
        currentHeight = minHeight;
        animController.reverse();
      } else {
        currentHeight = maxHeight;
        animController.forward();
      }
    }
  }

  onChange() {
    if (currentHeight != minHeight) {
      setState(() {
        currentHeight = minHeight;
        animController.reverse();
        widget.onChangeCollapse?.call(true);
      });
    } else {
      setState(() {
        currentHeight = maxHeight;
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
      child: AnimatedContainer(
        duration: widget.duration,
        height: currentHeight,
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
                opacity:
                    currentHeight != maxHeight && minHeight != null ? 1 : 0,
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
        turns: Tween(begin: 0.0, end: 0.5).animate(animController),
        child: Icon(Icons.keyboard_arrow_down),
      ),
      onTap: onChange,
    );
  }
}
