import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class CreateTourTab1 extends StatelessWidget {
  final formKey = GlobalKey<EditableTextState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          GradientTextFormField(
            label: '* Tên chuyến đi:',
          )
        ],
      ),
    );
  }
}
