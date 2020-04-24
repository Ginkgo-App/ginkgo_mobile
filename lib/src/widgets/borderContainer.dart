part of 'widgets.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final String icon;
  final String title;

  const BorderContainer(
      {Key key, this.padding, this.child, this.icon, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffE4D8D8), width: 1),
        borderRadius: BorderRadius.circular(5),
        color: context.colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (title != null || icon != null) ...[
            _Header(title: title, icon: icon),
            const SizedBox(height: 10)
          ],
          child,
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
    return Row(
      children: <Widget>[
        if (icon.isExistAndNotEmpty) Image.asset(icon),
        const SizedBox(width: 10),
        if (title.isExistAndNotEmpty)
          Text(
            title,
            style: context.textTheme.subhead.copyWith(
                color: DesignColor.blockHeader, fontWeight: FontWeight.bold),
          )
      ],
    );
  }
}
