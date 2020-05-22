import 'package:flutter/material.dart';
import 'package:base/base.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';

class InfoRow extends StatefulWidget {
  final String svgIcon;
  final String text;
  final String placeHolder;
  final bool editMode;

  const InfoRow(
      {Key key,
      @required this.svgIcon,
      this.text,
      this.placeHolder = '',
      this.editMode = false})
      : super(key: key);

  @override
  _InfoRowState createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> {
  final textFieldControler = TextEditingController();
  final GlobalKey globalKey = GlobalKey();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  onSubmit() {}

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
              child: SvgPicture.asset(widget.svgIcon, height: 20),
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
            ? Text(widget.text ?? '', style: textTheme.body1)
            : TextField(
                key: globalKey,
                controller: textFieldControler,
                style: textTheme.body1.copyWith(fontWeight: FontWeight.bold),
                enableSuggestions: true,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  hintText: widget.placeHolder ?? '',
                  border: InputBorder.none,
                ),
              ),
      ),
    );
  }

  buildChangeButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isEditing) {
            onSubmit();
          } else {
            textFieldControler.text = widget.text ?? '';
          }
          isEditing = !isEditing;
        });
      },
      child: Text(
        (isEditing ? Strings.button.saveChanges : Strings.button.edit)
            .toUpperCase(),
        style: textTheme.body1.copyWith(color: DesignColor.cta),
      ),
    );
  }
}
