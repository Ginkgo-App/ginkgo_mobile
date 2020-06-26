part of 'widgets.dart';

class PrimaryScaffold extends StatefulWidget {
  final bool isLoading;
  final Widget body;
  final PreferredSizeWidget appBar;
  final Color backgroundColor;
  final Gradient gradientBackground;
  final bool bottomPadding;
  final Widget bottomNavigationBar;
  final LoadDataController loadDataController;

  const PrimaryScaffold({
    Key key,
    this.body,
    this.isLoading = false,
    this.appBar,
    this.backgroundColor,
    this.gradientBackground,
    this.bottomNavigationBar,
    this.bottomPadding = true,
    this.loadDataController,
  })  : assert(backgroundColor == null || gradientBackground == null),
        super(key: key);

  @override
  _PrimaryScaffoldState createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  LoadDataController loadDataController;

  @override
  void initState() {
    super.initState();

    loadDataController = widget.loadDataController ?? LoadDataController();
    loadDataController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadDataProvider(
      controller: loadDataController,
      child: BlocBuilder(
          bloc: AuthBloc(),
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                Scaffold(
                  appBar: widget.appBar,
                  bottomNavigationBar: widget.bottomNavigationBar != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            widget.bottomNavigationBar,
                            if (widget.bottomPadding &&
                                SpinCircleBottomBarProvider.of(context) != null)
                              const SizedBox(height: 30)
                          ],
                        )
                      : null,
                  body: Container(
                    color: widget.backgroundColor,
                    decoration: BoxDecoration(
                        gradient: widget.gradientBackground == null &&
                                widget.backgroundColor == null
                            ? GradientColor.of(context).backgroundGradient
                            : null),
                    child: widget.body,
                  ),
                ),
                if (widget.isLoading || state is AuthStateLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withAlpha(150),
                      child: LoadingIndicator(),
                    ),
                  )
              ],
            );
          }),
    );
  }
}
