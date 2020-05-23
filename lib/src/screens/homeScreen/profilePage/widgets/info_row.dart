import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/homeProvider.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class InfoRowModel {
  final String svgIcon;
  final String text;
  final String placeHolder;
  final InfoRowType type;
  final EnumModel enumValue; // Giá trị enum hiện tại
  final List<EnumModel> enumData; // Danh sách các giá trị enum

  InfoRowModel(
    this.svgIcon,
    this.text, {
    this.placeHolder,
    this.type = InfoRowType.string,
    this.enumData,
    this.enumValue,
  });
}

enum InfoRowType { string, dateTime, enumable }

class EnumModel {
  final String value;
  final String label;

  EnumModel(this.value, this.label);
}

class InfoRow extends StatefulWidget {
  final InfoRowModel data;
  final bool editMode;
  final Function(String) onSubmit;
  final bool isLoading;

  const InfoRow({
    Key key,
    this.editMode = false,
    @required this.data,
    this.onSubmit,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _InfoRowState createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> {
  final textFieldControler = TextEditingController();
  final GlobalKey globalKey = GlobalKey();

  bool isEditing = false;
  DateTime selectedDate;
  EnumModel selectedEnum;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  buildContent() {
    return SizedBox(
      height: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: !widget.editMode || !isEditing
            ? Text(
                widget.data.type == InfoRowType.enumable
                    ? selectedEnum?.label
                    : widget.data.text ?? '',
                style: textTheme.body1)
            : widget.data.type == InfoRowType.enumable
                ? buildDropDown()
                : TextField(
                    key: globalKey,
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
    return widget.isLoading
        ? LoadingIndicator()
        : GestureDetector(
            onTap: () {
              switch (widget.data.type) {
                case InfoRowType.dateTime:
                  showDatePicker();
                  break;
                case InfoRowType.enumable:
                  setState(() {
                    if (isEditing) {
                      widget.onSubmit?.call(selectedEnum.value);
                    }
                    isEditing = !isEditing;
                  });
                  break;
                case InfoRowType.string:
                default:
                  setState(() {
                    if (isEditing) {
                      widget.onSubmit?.call(textFieldControler.text);
                    } else {
                      textFieldControler.text = widget.data.text ?? '';
                    }
                    isEditing = !isEditing;
                  });
              }
            },
            child: Text(
              (isEditing ? Strings.button.saveChanges : Strings.button.edit)
                  .toUpperCase(),
              style: textTheme.body1.copyWith(color: DesignColor.cta),
            ),
          );
  }

  buildDropDown() {
    return DropdownButton<EnumModel>(
      value: widget.data.enumValue,
      items: widget.data.enumData
          .map(
            (e) => DropdownMenuItem<EnumModel>(
              child: Text(e.label),
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
                        if (selectedDate != null) {
                          widget.onSubmit?.call(selectedDate.toString());
                        }
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
