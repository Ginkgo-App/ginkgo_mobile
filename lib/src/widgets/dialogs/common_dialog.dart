part of '../widgets.dart';

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      icon: SvgPicture.asset(
        Assets.icons.done,
        width: 50,
        height: 50,
      ),
      title: GradientText(
        'Thành công!',
        gradient: GradientColor.of(context).blogIcon,
      ),
    );
  }
}

class WarningDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CommonDialog extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const CommonDialog(
      {Key key, this.icon, this.title, this.content, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [icon, Expanded(child: title)],
          ),
          content,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions,
          )
        ],
      ),
    );
  }
}
