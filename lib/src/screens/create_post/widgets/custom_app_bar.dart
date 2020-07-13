part of 'create_post_widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key key,
      this.leading,
      this.title,
      this.actions,
      this.scaffoldKey,
      this.icon,
      this.onActionPressed,
      this.textController,
      this.isBackButton = false,
      this.isCrossButton = false,
      this.submitButtonText,
      this.isSubmitDisable = true,
      this.isbootomLine = true,
      this.onSearchChanged})
      : super(key: key);

  final List<Widget> actions;
  final Size appBarHeight = Size.fromHeight(56.0);
  final int icon;
  final bool isBackButton;
  final bool isbootomLine;
  final bool isCrossButton;
  final bool isSubmitDisable;
  final Widget leading;
  final Function onActionPressed;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String submitButtonText;
  final TextEditingController textController;
  final Widget title;
  final ValueChanged<String> onSearchChanged;

  @override
  Size get preferredSize => appBarHeight;

  List<Widget> _getActionButtons(BuildContext context) {
    return <Widget>[
      submitButtonText != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: customInkWell(
                context: context,
                radius: BorderRadius.circular(40),
                onPressed: () {
                  if (onActionPressed != null) onActionPressed();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  decoration: BoxDecoration(
                    color: !isSubmitDisable
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withAlpha(150),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    submitButtonText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            )
          : icon == null
              ? Container()
              : IconButton(
                  onPressed: () {
                    if (onActionPressed != null) onActionPressed();
                  },
                  icon: customIcon(context,
                      icon: icon,
                      istwitterIcon: true,
                      iconColor: context.colorScheme.primary,
                      size: 25),
                )
    ];
  }

  Widget _getUserAvatar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: customInkWell(
        context: context,
        onPressed: () {
          scaffoldKey.currentState.openDrawer();
        },
        child: customImage(context, FakeData.currentUser.avatar.smallThumb,
            height: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: context.colorScheme.onBackground),
      backgroundColor: context.colorScheme.background,
      elevation: 0,
      leading: isBackButton
          ? BackButton()
          : isCrossButton
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : _getUserAvatar(context),
      title: title ?? null,
      actions: _getActionButtons(context),
    );
  }
}
