part of 'widgets.dart';

class LoadingDotIndicator extends StatefulWidget {
  final String message;
  final Widget child;
  final int amountDots;

  const LoadingDotIndicator(
      {Key key, this.message, this.child, this.amountDots = 5})
      : assert(message == null || child == null),
        super(key: key);

  @override
  _LoadingDotIndicatorState createState() => _LoadingDotIndicatorState();
}

class _LoadingDotIndicatorState extends State<LoadingDotIndicator> {
  int currentDot = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        currentDot++;
        if (currentDot >= widget.amountDots) {
          currentDot = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (widget.message != null)
          Text(
            widget.message,
            style: context.textTheme.body1
                .copyWith(color: context.colorScheme.onBackground),
          ),
        if (widget.child != null) widget.child,
        _buildDots()
      ],
    );
  }

  _buildDots() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.amountDots,
          (i) => Padding(
            padding: EdgeInsets.only(right: i < widget.amountDots - 1 ? 5 : 0),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: currentDot == i
                      ? context.colorScheme.primary
                      : context.colorScheme.primaryVariant,
                  shape: BoxShape.circle),
            ),
          ),
        ),
      ),
    );
  }
}