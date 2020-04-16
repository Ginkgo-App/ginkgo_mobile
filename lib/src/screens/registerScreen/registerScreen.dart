part of screens;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _onRegister() {
    Navigator.of(context).pushNamed(Routes.home);
  }

  _onLoginNow() {
    Navigator.of(context).pushReplacementNamed(Routes.login);
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
                const SizedBox(height: 30),
                _buildHeader(),
                Expanded(child: const SizedBox.shrink()),
                ..._buildFields(),
                const SizedBox(height: 40),
                _buildButton(),
                Expanded(child: const SizedBox.shrink()),
                ..._buildBottom(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LogoWidget(),
        const SizedBox(width: 10),
        Expanded(
          child: AutoSizeText(
            Strings.registerScreen.title,
            style: context.textTheme.display1.copyWith(
                color: context.colorScheme.onBackground,
                fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  _buildFields() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: Strings.common.name,
          border: GradientUnderlineInputBorder(
            focusedGradient: GradientColor.of(context).primaryGradient,
          ),
        ),
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
        decoration: InputDecoration(
            labelText: Strings.common.phoneNumber,
            border: GradientUnderlineInputBorder(
              focusedGradient: GradientColor.of(context).primaryGradient,
            )),
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
      const SizedBox(height: 20),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            labelText: Strings.common.rePassword,
            border: GradientUnderlineInputBorder(
              focusedGradient: GradientColor.of(context).primaryGradient,
            )),
      ),
    ];
  }

  _buildButton() {
    return PrimaryButton(
      title: Strings.button.register,
      onPressed: _onRegister,
    );
  }

  _buildBottom() {
    return [
      Text(
        Strings.registerScreen.hadAccount,
        textAlign: TextAlign.center,
        style: context.textTheme.body1
            .apply(color: context.colorScheme.onBackground),
      ),
      GestureDetector(
        onTap: _onLoginNow,
        child: Text(
          Strings.registerScreen.loginNow,
          textAlign: TextAlign.center,
          style: context.textTheme.body1.copyWith(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
          ),
        ),
      )
    ];
  }
}
