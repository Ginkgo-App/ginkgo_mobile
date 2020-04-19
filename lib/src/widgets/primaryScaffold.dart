part of 'widgets.dart';

class PrimaryScaffold extends StatelessWidget {
  final bool isLoading;
  final Widget body;

  const PrimaryScaffold({Key key, this.body, this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: AuthBloc(),
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                body: body,
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
