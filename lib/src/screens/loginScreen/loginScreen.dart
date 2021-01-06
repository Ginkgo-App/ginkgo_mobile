part of screens;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthScreenBloc authScreenBloc = AuthScreenBloc();

  initState() {
    super.initState();
    Get.lazyPut(() => ChatListController());
  }

  _onLogin() {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      authScreenBloc.add(AuthScreenEventLogin(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }

  _onForgetPassword() {
    Toast.show(Strings.common.developingFeature, context);
  }

  _onFacebookLogin() {
    FocusScope.of(context).unfocus();
    authScreenBloc.add(AuthScreenEventFacebookLogin('access token'));
  }

  _onGoogleLogin() {
    FocusScope.of(context).unfocus();
    Toast.show(Strings.common.developingFeature, context);
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height < 700
                        ? null
                        : MediaQuery.of(context).size.height,
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
                        Flexible(
                            child: Container(
                          height: MediaQuery.of(context).size.height < 700
                              ? 40
                              : null,
                        )),
                        ..._buildSocialLogin(),
                        const SizedBox(height: 20),
                        ..._buildBottom(),
                        const SizedBox(height: 20),
                      ],
                    ),
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
          const SizedBox(height: 20),
          GradientTextFormField(
            validator: validatePassword,
            controller: passwordController,
            label: Strings.common.password,
            obscureText: true,
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
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _onForgetPassword,
            child: Text(
              Strings.button.forgotPassword,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyText2.apply(
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSocialLogin() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 1,
              color: context.colorScheme.onSurface,
            ),
          ),
          Text(
            Strings.loginScreen.orLoginWith,
            style: context.textTheme.bodyText2.copyWith(
                color: context.colorScheme.onBackground,
                fontStyle: FontStyle.italic),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        children: <Widget>[
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _onFacebookLogin,
            child: _buildSocialButton(Assets.icons.facebookSquare),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: _buildSocialButton(Assets.icons.googlePlusSquare),
            onPressed: _onGoogleLogin,
          ),
        ],
      ),
    ];
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

  _buildSocialButton(String icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SvgPicture.asset(icon, height: 50),
    );
  }
}
