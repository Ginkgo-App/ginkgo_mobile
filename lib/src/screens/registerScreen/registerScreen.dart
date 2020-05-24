part of screens;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final AuthScreenBloc authScreenBloc = AuthScreenBloc();

  _onRegister() {
    if (formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      authScreenBloc.add(AuthScreenEventRegister(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
      ));
    }
  }

  _onLoginNow() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  String _validateRePassword(String rePassword) {
    if (!rePassword.isExistAndNotEmpty) {
      return Strings.error.emptyRequiredInput;
    } else if (rePassword != passwordController.text) {
      return Strings.error.rePasswordIsNotMatch;
    }
    return null;
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
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          _buildHeader(),
                          const SizedBox(height: 40),
                          ..._buildFields(),
                          const SizedBox(height: 40),
                          _buildButton(),
                          const SizedBox(height: 40),
                          ..._buildBottom(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _buildHeader() {
    return LogoWidget(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
    );
  }

  _buildFields() {
    return [
      GradientTextFormField(
        validator: validateName,
        controller: nameController,
        label: Strings.common.name,
      ),
      const SizedBox(height: 20),
      GradientTextFormField(
        validator: validateEmail,
        controller: emailController,
        label: Strings.common.email,
      ),
      const SizedBox(height: 20),
      GradientTextFormField(
        validator: validatePhoneNumber,
        controller: phoneNumberController,
        label: Strings.common.phoneNumber,
      ),
      const SizedBox(height: 20),
      GradientTextFormField(
        validator: validatePassword,
        controller: passwordController,
        label: Strings.common.password,
        obscureText: true,
      ),
      const SizedBox(height: 20),
      GradientTextFormField(
        validator: _validateRePassword,
        controller: rePasswordController,
        label: Strings.common.rePassword,
        obscureText: true,
      ),
      BlocBuilder(
        bloc: authScreenBloc,
        builder: (context, state) => state is AuthScreenStateFailure
            ? Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  state.error.toString() ?? Strings.error.unknowError,
                  textAlign: TextAlign.left,
                  style: context.textTheme.body1.copyWith(
                    color: context.colorScheme.error,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      )
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
