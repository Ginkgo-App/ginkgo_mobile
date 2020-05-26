part of '../widgets.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final List<Widget> children;
  final EdgeInsets childPadding;
  final EdgeInsets margin;
  final String icon;
  final String title;
  final List<Widget> actions;

  const BorderContainer({
    Key key,
    this.childPadding,
    this.child,
    this.icon,
    this.title,
    this.children,
    this.margin,
    this.actions = const [],
  })  : assert(child == null || children == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        // border: Border.all(color: Color(0xffE4D8D8), width: 1),
        boxShadow: DesignColor.defaultDropShadow,
        borderRadius: BorderRadius.circular(5),
        color: context.colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null || icon != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: _Header(
                title: title,
                icon: icon,
                actions: actions,
              ),
            ),
          if (child != null)
            Padding(
              padding: childPadding ?? EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: child ?? const SizedBox.shrink(),
            ),
          if (children != null)
            Padding(
              padding: childPadding ?? EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: children,
              ),
            )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final String icon;
  final List<Widget> actions;

  const _Header({Key key, this.title, this.icon, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          if (icon.isExistAndNotEmpty) ...[
            SvgPicture.asset(
              icon,
              height: 30,
            ),
            const SizedBox(width: 10)
          ],
          if (title.isExistAndNotEmpty)
            Expanded(
              child: Text(
                title,
                style: context.textTheme.subhead.copyWith(
                    color: DesignColor.blockHeader,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ...actions
        ],
      ),
    );
  }
}