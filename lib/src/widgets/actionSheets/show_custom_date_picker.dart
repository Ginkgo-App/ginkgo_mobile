import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/base.dart';
import 'package:ginkgo_mobile/src/utils/strings.dart';

import '../widgets.dart';

showCustomDatePicker(
  BuildContext context, {
  DateTime selectedDate,
  Function(DateTime) onSubmit,
  @required DateTime minimumDate,
  @required DateTime maximumDate,
  String buttonLabel,
}) {
  showDialog(
    context: context,
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
                        style: textTheme.bodyText2
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
                      initialDateTime: selectedDate == null ||
                              selectedDate.compareTo(maximumDate) > 0 ||
                              selectedDate.compareTo(minimumDate) < 0
                          ? minimumDate.add(Duration(microseconds: 1))
                          : selectedDate,
                      onDateTimeChanged: (DateTime newdate) {
                        selectedDate = newdate;
                      },
                      minimumYear: minimumDate?.year,
                      maximumYear: maximumDate?.year,
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: maximumDate,
                      minimumDate: minimumDate,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: PrimaryButton(
                    borderRadius: BorderRadius.circular(5),
                    title: buttonLabel ?? Strings.button.saveChanges,
                    onPressed: () {
                      Navigator.pop(context);
                      if (selectedDate == null) {
                        selectedDate = DateTime(1998, 2, 1);
                      }
                      onSubmit(selectedDate);
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
