part of '../widgets.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final PreferredSizeWidget bottom;
  final bool showBackButton;
  final String title;

  BackAppBar(
      {Key key,
      this.actions,
      this.bottom,
      this.showBackButton = true,
      this.title})
      : preferredSize = Size.fromHeight(
            56.0 + (bottom != null ? bottom.preferredSize.height : 0)),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colorScheme.background,
      elevation: 4,
      centerTitle: true,
      bottom: bottom,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: context.colorScheme.onBackground,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : Container(),
      title: Text(
        title ?? 'Ginkgo',
        style: context.textTheme.title.merge(
          TextStyle(color: context.colorScheme.onBackground),
        ),
      ),
      actions: actions,
    );
  }
}
