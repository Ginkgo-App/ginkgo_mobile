library spincircle_bottom_bar;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

part 'modals.dart';

class SpinCircleBottomBarProvider extends InheritedWidget {
  SpinCircleBottomBarProvider({Widget child}) : super(child: child);

  static SpinCircleBottomBarProvider of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType(aspect: SpinCircleBottomBarProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class SpinCircleBottomBarHolder extends StatelessWidget {
  final SCBottomBarDetails bottomNavigationBar;
  final Widget child;

  const SpinCircleBottomBarHolder({
    Key key,
    @required this.bottomNavigationBar,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            SpinCircleBottomBarProvider(child: Expanded(child: child)),
            Container(
              height: bottomNavigationBar.bnbHeight ?? 80,
            )
          ],
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: SpinCircleBottomBar(
              bottomNavigationBar: bottomNavigationBar,
            ))
      ],
    );
  }
}

class SpinCircleBottomBar extends StatefulWidget {
  final SCBottomBarDetails bottomNavigationBar;

  const SpinCircleBottomBar({Key key, this.bottomNavigationBar})
      : super(key: key);

  @override
  _SpinCircleBottomBarState createState() => _SpinCircleBottomBarState();
}

enum ExpansionStatus { OPEN, CLOSE, IDLE }

class _SpinCircleBottomBarState extends State<SpinCircleBottomBar> {
  ExpansionStatus expansionStatus = ExpansionStatus.IDLE;
  SCBottomBarDetails expandableBottomBarDetails;
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  set activeIndex(int v) {
    setState(() {
      if (v >= (expandableBottomBarDetails.items.length - 1) / 2) {
        _activeIndex = v + 1;
      } else {
        _activeIndex = v;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    expandableBottomBarDetails = widget.bottomNavigationBar;
    // expandableBottomBarDetails.items
    //     .insert((expandableBottomBarDetails.items.length / 2).floor(), null);
    expandableBottomBarDetails.circleColors =
        expandableBottomBarDetails.circleColors ??
            [Colors.white, Colors.blue, Colors.red];
    expandableBottomBarDetails.actionButtonDetails =
        expandableBottomBarDetails.actionButtonDetails ??
            SCActionButtonDetails(
                color: Colors.blue,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                elevation: 0);
    expandableBottomBarDetails?.tabController?.addListener(() {
      setState(() {
        activeIndex = expandableBottomBarDetails.tabController.index;
      });
    });
    activeIndex = expandableBottomBarDetails?.tabController?.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final double bottomBarHeight = expandableBottomBarDetails.bnbHeight ?? 80;
    final IconThemeData iconTheme = expandableBottomBarDetails.iconTheme ??
        IconThemeData(color: Colors.black45);
    final IconThemeData activeIconTheme =
        expandableBottomBarDetails.activeIconTheme ??
            IconThemeData(color: Colors.black);
    final TextStyle textStyle = expandableBottomBarDetails.titleStyle ??
        TextStyle(
            color: Colors.black45, fontWeight: FontWeight.normal, fontSize: 12);
    final TextStyle activeTextStyle =
        expandableBottomBarDetails.activeTitleStyle ??
            TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
    final SCActionButtonDetails actionButtonDetails =
        expandableBottomBarDetails.actionButtonDetails;
    bool shouldOpen = expansionStatus == ExpansionStatus.OPEN;

    final radius = bottomBarHeight * 3;

    return Container(
        height: radius,
        width: width,
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[
            if (expansionStatus != ExpansionStatus.IDLE) ...[
              Positioned(
                bottom: bottomBarHeight,
                left: 0,
                right: 0,
                child: Stack(
                  children: <Widget>[
                    TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: shouldOpen ? -3.14 : 0,
                          end: shouldOpen ? 0 : -3.14),
                      curve: Curves.easeInOutQuad,
                      duration: Duration(milliseconds: shouldOpen ? 500 : 800),
                      builder:
                          (BuildContext context, double value, Widget child) {
                        return Transform.rotate(
                          angle: value,
                          child: child,
                          alignment: Alignment.bottomCenter,
                        );
                      },
                      child: EmptyLayer(
                        radius: radius,
                        color: expandableBottomBarDetails.circleColors[2],
                      ),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: shouldOpen ? -3.14 : 0,
                          end: shouldOpen ? 0 : -3.14),
                      curve: Curves.easeInOutQuad,
                      duration: Duration(milliseconds: 600),
                      builder:
                          (BuildContext context, double value, Widget child) {
                        return Transform.rotate(
                          angle: value,
                          child: child,
                          alignment: Alignment.bottomCenter,
                        );
                      },
                      child: EmptyLayer(
                        radius: radius,
                        color: expandableBottomBarDetails.circleColors[1],
                      ),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: shouldOpen ? -3.14 : 0,
                          end: shouldOpen ? 0 : -3.14),
                      duration: Duration(milliseconds: shouldOpen ? 800 : 500),
                      curve: Curves.easeInOutQuad,
                      builder:
                          (BuildContext context, double value, Widget child) {
                        return Transform.rotate(
                          angle: value,
                          child: child,
                          alignment: Alignment.bottomCenter,
                        );
                      },
                      child: PrimaryCircle(
                        circleItems: expandableBottomBarDetails.circleItems,
                        radius: radius,
                        color: expandableBottomBarDetails.circleColors[0],
                      ),
                    ),
                  ],
                ),
              )
            ],
            Positioned(
              bottom: 0,
              child: Container(
                height: bottomBarHeight,
                width: width,
                decoration: BoxDecoration(
                    color: expandableBottomBarDetails.backgroundColor ??
                        Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(55),
                          offset: Offset(
                              0, expandableBottomBarDetails.elevation ?? 0),
                          blurRadius: 10)
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: expandableBottomBarDetails.items
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        SCBottomBarItem itemDetails = entry.value;
                        bool isActive = activeIndex == index;
                        return Flexible(
                            child: itemDetails != null
                                ? GestureDetector(
                                    onTap: () {
                                      itemDetails.onPressed();
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            isActive
                                                ? itemDetails.svgActiveIcon ??
                                                    itemDetails.svgIcon
                                                : itemDetails.svgIcon,
                                            color: isActive
                                                ? activeIconTheme.color
                                                : iconTheme.color,
                                            width: isActive
                                                ? activeIconTheme.size
                                                : iconTheme.size,
                                            height: isActive
                                                ? activeIconTheme.size
                                                : iconTheme.size,
                                          ),
                                          itemDetails.title != null
                                              ? Text(itemDetails.title,
                                                  style: isActive
                                                      ? activeTextStyle
                                                      : textStyle)
                                              : Center()
                                        ],
                                      ),
                                    ),
                                  )
                                : Center());
                      }).toList()
                            ..insert(
                              (expandableBottomBarDetails.items.length / 2)
                                  .floor(),
                              Flexible(
                                child: Center(),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: bottomBarHeight / 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(
                        begin: shouldOpen ? 0.0 : 6.28319,
                        end: shouldOpen ? 6.28319 : 0),
                    duration: Duration(milliseconds: 250),
                    builder: (context, angle, child) {
                      return Transform.rotate(
                          angle: expansionStatus == ExpansionStatus.IDLE
                              ? 0.0
                              : angle,
                          alignment: Alignment.center,
                          child: child);
                    },
                    child: FloatingActionButton(
                        elevation: actionButtonDetails.elevation,
                        backgroundColor: actionButtonDetails.color,
                        child: shouldOpen
                            ? Icon(Icons.close)
                            : actionButtonDetails.icon,
                        onPressed: () {
                          if (expansionStatus == ExpansionStatus.IDLE) {
                            this.setState(() {
                              expansionStatus = ExpansionStatus.OPEN;
                            });
                          } else {
                            this.setState(() {
                              expansionStatus =
                                  (expansionStatus == ExpansionStatus.OPEN)
                                      ? ExpansionStatus.CLOSE
                                      : ExpansionStatus.OPEN;
                            });
                          }
                        }),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class PrimaryCircle extends StatelessWidget {
  final List<SCItem> circleItems;
  final Color color;
  final double radius;

  const PrimaryCircle(
      {Key key,
      @required this.color,
      @required this.radius,
      @required this.circleItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double radianGap = 3.14159 / circleItems.length;
    double start = radianGap / 2;
    return ClipRect(
      child: Align(
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: circleItems.asMap().entries.map((entry) {
                SCItem value = entry.value;
                return Transform.translate(
                  offset: Offset.fromDirection(
                      -(start + (entry.key * radianGap)), radius / 3),
                  child: GestureDetector(
                    onTap: value.onPressed,
                    child: value.icon,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyLayer extends StatelessWidget {
  final Color color;
  final double radius;

  const EmptyLayer({Key key, this.color, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        heightFactor: 0.5,
        alignment: Alignment.topCenter,
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(),
        ),
      ),
    );
  }
}
