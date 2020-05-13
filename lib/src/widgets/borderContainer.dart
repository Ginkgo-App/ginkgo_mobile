part of 'widgets.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final List<Widget> children;
  final EdgeInsets childPadding;
  final String icon;
  final String title;

  const BorderContainer(
      {Key key,
      this.childPadding,
      this.child,
      this.icon,
      this.title,
      this.children})
      : assert(child == null || children == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: _Header(title: title, icon: icon),
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

  const _Header({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          if (icon.isExistAndNotEmpty)
            SvgPicture.asset(
              icon,
              height: 30,
            ),
          const SizedBox(width: 10),
          if (title.isExistAndNotEmpty)
            Text(
              title,
              style: context.textTheme.subhead.copyWith(
                  color: DesignColor.blockHeader, fontWeight: FontWeight.bold),
            )
        ],
      ),
    );
  }
}
