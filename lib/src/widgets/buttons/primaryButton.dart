part of '../widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const PrimaryButton({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
            gradient: GradientColor.of(context).primaryGradient,
            borderRadius: BorderRadius.circular(90)),
        child: Text(
          title,
          style: context.textTheme.button
              .apply(color: context.colorScheme.onPrimary),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
