part of 'create_tour_tabs.dart';

class CreateTourTab1 extends StatefulWidget {
  final String initTourName;

  CreateTourTab1({
    Key key,
    this.initTourName,
  }) : super(key: key);

  @override
  _CreateTourTab1State createState() => _CreateTourTab1State();
}

class _CreateTourTab1State extends State<CreateTourTab1> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  final TextEditingController totalMemberController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initTourName);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(name: widget.initTourName);
    });
  }

  onChange({String name, int maxMember, double price}) {
    BlocProvider.of<CreateTourBloc>(context).add(
      CreateTourEventChangeData(
        formKey.currentState.validate(),
        TourToPost(
          name: name ?? '',
          maxMember:
              maxMember ?? int.tryParse(totalMemberController?.text) ?? 1,
          price: price ?? double.tryParse(priceController?.text) ?? 10000,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SpacingColumn(
        spacing: 10,
        isSpacingHeadTale: true,
        children: [
          CreateTourTextFieldBase(
            isRequired: true,
            label: 'Tên chuyến đi:',
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: GradientOutlineInputBorder(
                  focusedGradient: GradientColor.of(context).primaryGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: 'Tên chuyến đi',
              ),
              validator: (value) {
                if (!value.isExistAndNotEmpty) {
                  return Strings.error.emptyRequiredInput;
                }
                return null;
              },
              onChanged: (value) {
                onChange(name: value);
              },
            ),
          ),
          SpacingRow(
            spacing: 10,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: CreateTourTextFieldBase(
                  isRequired: true,
                  label: 'Số người dự kiến:',
                  unit: 'người',
                  child: NumberInputWithIncrementDecrement(
                    controller: totalMemberController,
                    min: 1,
                    max: 100,
                    incDecFactor: 1,
                    isInt: true,
                    initialValue: 1,
                    numberFieldDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: GradientOutlineInputBorder(
                        focusedGradient:
                            GradientColor.of(context).primaryGradient,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Số người dự kiến',
                    ),
                    validator: (value) {
                      if (!value.isExistAndNotEmpty) {
                        return Strings.error.emptyRequiredInput;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      onChange(maxMember: int.tryParse(value) ?? 1);
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: CreateTourTextFieldBase(
                  isRequired: true,
                  label: 'Số tiền dự kiến:',
                  unit: 'đồng',
                  child: NumberInputWithIncrementDecrement(
                    controller: priceController,
                    min: 10000,
                    incDecFactor: 1000,
                    initialValue: 10000,
                    numberFieldDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: GradientOutlineInputBorder(
                        focusedGradient:
                            GradientColor.of(context).primaryGradient,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Số tiền dự kiến',
                    ),
                    validator: (value) {
                      if (!value.isExistAndNotEmpty) {
                        return Strings.error.emptyRequiredInput;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      onChange(price: int.tryParse(value) ?? 1);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
