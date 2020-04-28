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
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  height: MediaQuery.of(context).size.height,
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildFormAndLogo(state is AuthScreenStateFailure
                            ? state.error.toString()
                            : ''),
                        Expanded(child: Container()),
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

  _buildFormAndLogo(String errorMessage) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          LogoWidget(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(height: 20),
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
                style: context.textTheme.body1.copyWith(
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
              style: context.textTheme.body1.apply(
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
          Text(
            '                    ',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              color: context.colorScheme.onSurface,
            ),
          ),
          Text(
            Strings.loginScreen.orLoginWith,
            style: context.textTheme.body1.copyWith(
                color: context.colorScheme.onBackground,
                fontStyle: FontStyle.italic),
          ),
          Text(
            '                    ',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
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
            child: SvgPicture.asset(Assets.icons.facebookSquare),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(Assets.icons.googlePlusSquare),
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
        style: context.textTheme.body1
            .apply(color: context.colorScheme.onBackground),
      ),
      GestureDetector(
        onTap: _onRegister,
        child: Text(
          Strings.loginScreen.registerNow,
          textAlign: TextAlign.center,
          style: context.textTheme.body1.copyWith(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ];
  }
}
