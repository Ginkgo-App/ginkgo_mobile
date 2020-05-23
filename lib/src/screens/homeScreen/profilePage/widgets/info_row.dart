import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/blocs/update_profile_bloc/update_profile_bloc.dart';
import 'package:ginkgo_mobile/src/models/key_value.dart';
import 'package:ginkgo_mobile/src/models/user.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/changeButton.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class InfoRowModel {
  final GlobalKey key = GlobalKey();
  final String svgIcon;
  final String text;
  final String placeHolder;
  final InfoRowType type;
  final KeyValue enumValue; // Giá trị enum hiện tại
  final List<KeyValue> enumData; // Danh sách các giá trị enum
  final UserToPut Function(String) toUserToPut;
  final bool editable;

  InfoRowModel(
    this.svgIcon,
    this.text, {
    @required this.toUserToPut,
    this.placeHolder,
    this.type = InfoRowType.string,
    this.enumData,
    this.enumValue,
    this.editable = true,
  });
}

enum InfoRowType { string, dateTime, enumable }

class InfoRow extends StatefulWidget {
  final InfoRowModel data;
  final bool editMode;

  const InfoRow({
    Key key,
    this.editMode = false,
    @required this.data,
  }) : super(key: key);

  @override
  _InfoRowState createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> {
  final textFieldControler = TextEditingController();
  final UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();

  bool isEditing = false;
  DateTime selectedDate;
  KeyValue selectedEnum;

  onSubmit() {
    final UserToPut userToPut = widget.data.toUserToPut(
      widget.data.type == InfoRowType.string
          ? textFieldControler.text
          : (widget.data.type == InfoRowType.dateTime
              ? selectedDate.toString()
              : selectedEnum.key),
    );
    updateProfileBloc.add(UpdateProfileEventUpdate(userToPut));
  }

  @override
  void dispose() {
    updateProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: updateProfileBloc,
      listener: (context, state) {
        if (state is UpdateProfileStateFailure) {
          Toast.show('${Strings.error.updateProfile}\n${state.error}', context,
              duration: 3);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 35,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(widget.data.svgIcon, height: 20),
              ),
            ),
            Expanded(
              child: buildContent(),
            ),
            const SizedBox(width: 5),
            if (widget.editMode) buildChangeButton()
          ],
        ),
      ),
    );
  }

  buildContent() {
    return SizedBox(
      height: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: !widget.editMode || !isEditing || !widget.data.editable
            ? Text(
                widget.data.type == InfoRowType.enumable
                    ? selectedEnum?.value ?? ''
                    : widget.data.text ?? '',
                style: textTheme.body1)
            : widget.data.type == InfoRowType.enumable
                ? buildDropDown()
                : TextField(
                    autofocus: true,
                    controller: textFieldControler,
                    style:
                        textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                    enableSuggestions: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      hintText: widget.data.placeHolder ?? '',
                      border: InputBorder.none,
                    ),
                  ),
      ),
    );
  }

  buildChangeButton() {
    return BlocBuilder(
      bloc: updateProfileBloc,
      builder: (context, state) => widget.data.editable
          ? ChangeButton(
              isEditing: isEditing,
              isLoading: state is UpdateProfileStateLoading,
              onTap: () {
                switch (widget.data.type) {
                  case InfoRowType.dateTime:
                    showDatePicker();
                    break;
                  case InfoRowType.enumable:
                    setState(() {
                      if (isEditing) {
                        onSubmit();
                      }
                      isEditing = !isEditing;
                    });
                    break;
                  case InfoRowType.string:
                  default:
                    setState(() {
                      if (isEditing) {
                        onSubmit();
                      } else {
                        textFieldControler.text = widget.data.text ?? '';
                      }
                      isEditing = !isEditing;
                    });
                }
              },
            )
          : const SizedBox.shrink(),
    );
  }

  buildDropDown() {
    return DropdownButton<KeyValue>(
      value: selectedEnum,
      style: context.textTheme.body1.copyWith(fontWeight: FontWeight.bold),
      underline: const SizedBox.shrink(),
      items: widget.data.enumData
          .map(
            (e) => DropdownMenuItem<KeyValue>(
              child: Text(e.value),
              value: e,
            ),
          )
          .toList(),
      onChanged: (v) => setState(
        () {
          selectedEnum = v;
        },
      ),
    );
  }

  showDatePicker() {
    showDialog(
      context: HomeProvider.of(context).context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Chọn ngày',
                          style: textTheme.body1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: context.colorScheme.onBackground,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Center(
                      child: CupertinoDatePicker(
                        initialDateTime: widget.data.text.toVietNameseDate() ??
                            DateTime(1998, 2, 1),
                        onDateTimeChanged: (DateTime newdate) {
                          selectedDate = newdate;
                        },
                        minimumYear: 1911,
                        maximumYear: 2018,
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: PrimaryButton(
                      borderRadius: BorderRadius.circular(5),
                      title: Strings.button.saveChanges,
                      onPressed: () {
                        Navigator.pop(context);
                        if (selectedDate == null) {
                          selectedDate = widget.data.text.toVietNameseDate() ??
                              DateTime(1998, 2, 1);
                        }
                        onSubmit();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
