part of 'widgets.dart';

class PrimaryScaffold extends StatelessWidget {
  final bool isLoading;
  final Widget body;
  final PreferredSizeWidget appBar;
  final Color backgroundColor;
  final Gradient gradientBackground;
  final bool bottomPadding;
  final Widget bottomNavigationBar;

  const PrimaryScaffold({
    Key key,
    this.body,
    this.isLoading = false,
    this.appBar,
    this.backgroundColor,
    this.gradientBackground,
    this.bottomNavigationBar,
    this.bottomPadding = true,
  })  : assert(backgroundColor == null || gradientBackground == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: AuthBloc(),
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: appBar,
                bottomNavigationBar: bottomNavigationBar != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          bottomNavigationBar,
                          if (bottomPadding &&
                              SpinCircleBottomBarProvider.of(context) != null)
                            const SizedBox(height: 30)
                        ],
                      )
                    : null,
                body: Container(
                  color: backgroundColor,
                  decoration: BoxDecoration(
                      gradient:
                          gradientBackground == null && backgroundColor == null
                              ? GradientColor.of(context).backgroundGradient
                              : null),
                  child: body,
                ),
              ),
              if (isLoading || state is AuthStateLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withAlpha(150),
                    child: LoadingIndicator(),
                  ),
                )
            ],
          );
        });
  }
}
