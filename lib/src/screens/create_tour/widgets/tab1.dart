import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/utils/gradientColor.dart';
import 'package:ginkgo_mobile/src/widgets/gradientOutlineBorder.dart';

class CreateTourTab1 extends StatelessWidget {
  final formKey = GlobalKey<EditableTextState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [],
      ),
    );
  }

  buildTextField(BuildContext context) {
    return Column(
      children: <Widget>[
        
        TextFormField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            border: GradientOutlineInputBorder(
                focusedGradient: GradientColor.of(context).primaryGradient,
                borderRadius: BorderRadius.circular(5)),
            hasFloatingPlaceholder: true,
            hintText: 'Ten chuyen di',
          ),
        ),
      ],
    );
  }
}
