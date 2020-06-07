import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/blocs/update_profile/update_profile_bloc.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/changeButton.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/actionSheets/show_custom_date_picker.dart';
import 'package:ginkgo_mobile/src/widgets/customs/toast.dart';

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

          if (widget.data.type == InfoRowType.enumable) {
            setState(() {
              selectedEnum = widget.data.enumValue;
              selectedDate = widget.data.text.toVietNameseDate();
            });
          }
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
                    ? selectedEnum?.value ?? widget.data.enumValue.value ?? ''
                    : selectedDate?.toVietNamese() ?? widget.data.text ?? '',
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
      value: selectedEnum ?? widget.data.enumValue,
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
    selectedDate = widget.data.text?.toVietNameseDate();
    showCustomDatePicker(
      HomeProvider.of(context).context,
      selectedDate: selectedDate,
      onSubmit: (date) {
        selectedDate = date;
        onSubmit();
      },
      minimumDate: DateTime(1911),
      maximumDate: DateTime(2018),
    );
  }
}
