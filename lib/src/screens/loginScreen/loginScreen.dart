part of screens;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _onLogin() {}

  _onForgetPassword() {}

  _onFacebookLogin() {}

  _onGoogleLogin() {}

  _onRegister() {
    AppConfig.navigatorKey.currentState.pushReplacementNamed(Routes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ..._buildFormAndLogo(),
                Expanded(child: const SizedBox.shrink()),
                ..._buildSocialLogin(),
                const SizedBox(height: 20),
                ..._buildBottom(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildFormAndLogo() {
    return [
      const SizedBox(height: 30),
      LogoWidget(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
      ),
      const SizedBox(height: 20),
      TextFormField(
        decoration: InputDecoration(
          labelText: Strings.common.email,
          border: GradientUnderlineInputBorder(
            focusedGradient: GradientColor.of(context).primaryGradient,
          ),
        ),
      ),
      const SizedBox(height: 20),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: Strings.common.password,
            border: GradientUnderlineInputBorder(
              focusedGradient: GradientColor.of(context).primaryGradient,
            )),
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
    ];
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
            child: Image.asset('assets/icons/facebook.png'),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset('assets/icons/google-plus.png'),
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
