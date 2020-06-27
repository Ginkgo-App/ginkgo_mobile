part of screens;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AuthBloc().add(AuthEventStartApp());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: CurrentUserBloc(),
      listener: (context, state) {
        if (state is CurrentUserStateFailure) {
          AwesomeDialog(
            context: context,
            dismissOnTouchOutside: false,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Lỗi khi tải thông tin cá nhân.',
            desc: 'Vui lòng thử lại hoặc đăng xuất.',
            btnCancelOnPress: () {
              // Navigator.pop(context);
              AuthBloc().add(AuthEventLogout());
            },
            btnCancelText: 'ĐĂNG XUẤT',
            btnOkOnPress: () {
              // Navigator.pop(context);
              CurrentUserBloc().add(CurrentUserEventFetch());
            },
            btnOkText: 'TẢI LẠI',
          )..show();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image.asset(
              Assets.images.background,
              fit: BoxFit.fill,
            )),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LogoWidget(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                  const SizedBox(height: 20),
                  LoadingDotIndicator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
