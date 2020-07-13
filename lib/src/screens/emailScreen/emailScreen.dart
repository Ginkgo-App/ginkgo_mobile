part of screens;

class EmailScreenArgs {
  final String accessToken;

  EmailScreenArgs(this.accessToken);
}

class EmailScreen extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'EmailFormKey');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthScreenBloc authScreenBloc = AuthScreenBloc();
  EmailScreenArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      args = ModalRoute.of(context).settings.arguments;
      if (args == null || args.accessToken == null) {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  _onLogin() {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      authScreenBloc.add(AuthScreenEventFacebookLoginWithEmail(
        accessToken: args.accessToken,
        email: emailController.text,
      ));
    }
  }

  _onRegister() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(Routes.register);
  }

  @override
  void dispose() {
    authScreenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: authScreenBloc,
      builder: (context, state) {
        return PrimaryScaffold(
          isLoading: state is AuthScreenStateLoading,
          body: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset(
                Assets.images.authBackground,
                fit: BoxFit.fill,
              )),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 30),
                      LogoWidget(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      Flexible(child: Container()),
                      _buildForm(state is AuthScreenStateFailure
                          ? state.error.toString()
                          : ''),
                      Flexible(child: Container()),
                      ..._buildBottom(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Positioned.fill(
              //   child: IgnorePointer(child: Particles(10)),
              // )
            ],
          ),
        );
      },
    );
  }

  _buildForm(String errorMessage) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientTextFormField(
            validator: validateEmail,
            controller: emailController,
            label: Strings.common.email,
          ),
          if (errorMessage.isExistAndNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                errorMessage,
                textAlign: TextAlign.left,
                style: context.textTheme.bodyText2.copyWith(
                  color: context.colorScheme.error,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          const SizedBox(height: 40),
          PrimaryButton(
            title: Strings.button.login,
            onPressed: _onLogin,
          ),
        ],
      ),
    );
  }

  _buildBottom() {
    return [
      Text(
        Strings.loginScreen.doNotHaveAccount,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyText2
            .apply(color: context.colorScheme.onBackground),
      ),
      GestureDetector(
        onTap: _onRegister,
        child: Text(
          Strings.loginScreen.registerNow,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyText2.copyWith(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ];
  }
}
