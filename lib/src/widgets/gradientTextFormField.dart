part of widget;

class GradientTextFormField extends StatelessWidget {
  final String Function(String) validator;
  final String label;
  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;

  const GradientTextFormField(
      {Key key,
      this.validator,
      this.label,
      this.controller,
      this.placeholder,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder,
        border: GradientUnderlineInputBorder(
          focusedGradient: GradientColor.of(context).primaryGradient,
        ),
      ),
    );
  }
}
