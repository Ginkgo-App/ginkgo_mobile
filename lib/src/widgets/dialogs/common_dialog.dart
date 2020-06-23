part of '../widgets.dart';

class SuccessDialog extends StatelessWidget {
  final String svgIcon;
  final Widget content;

  const SuccessDialog({Key key, this.content, this.svgIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      icon: SvgPicture.asset(
        svgIcon ?? Assets.icons.done,
        width: 50,
        height: 50,
      ),
      title: GradientText(
        'Thành công!',
        style: context.textTheme.headline6,
        gradient: GradientColor.of(context).blogIcon,
      ),
      content: content,
      actions: <Widget>[
        CupertinoButton(
            child: Text(
              'XÁC NHẬN',
              style: context.textTheme.bodyText2.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}

class WarningDialog extends StatelessWidget {
  final String svgIcon;
  final String title;
  final Widget content;

  const WarningDialog({Key key, this.svgIcon, this.title = 'Cảnh báo !!!', this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      icon: SvgPicture.asset(
        svgIcon ?? Assets.icons.warning,
        width: 50,
        height: 50,
      ),
      title: GradientText(
        title,
        style: context.textTheme.headline6,
        gradient: GradientColor.of(context).blogIcon,
      ),
      content: content,
      actions: <Widget>[
        CupertinoButton(
            child: Text(
              'HỦY BỎ',
              style: context.textTheme.bodyText2.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}

class CommonDialog extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const CommonDialog(
      {Key key, this.icon, this.title, this.content, this.actions = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SpacingRow(spacing: 10, children: [icon, Expanded(child: title)]),
      actions: actions,
      content: content,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      titlePadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
  }
}
