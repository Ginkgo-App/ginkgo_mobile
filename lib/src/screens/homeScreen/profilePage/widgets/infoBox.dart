import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/screens/homeScreen/profilePage/widgets/info_row.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/spacingColumn.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class InfoBox extends StatelessWidget {
  final User user;
  final bool editMode;

  const InfoBox({Key key, @required this.user, this.editMode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.resume,
      title: 'Thông tin cá nhân',
      child: SpacingColumn(
        separator: Container(
          margin: EdgeInsets.only(left: 40),
          color: DesignColor.darkerWhite,
          height: 0.5,
        ),
        spacing: 10,
        children: [
          InfoRowModel(
            Assets.icons.job,
            user?.job,
            placeHolder: 'Nghề nghiệp',
            toUserToPut: (text) => UserToPut(job: text),
          ),
          InfoRowModel(
            Assets.icons.email,
            user?.email,
            placeHolder: 'Email',
            editable: false,
            toUserToPut: (text) => null,
          ),
          InfoRowModel(
            Assets.icons.phone,
            user?.phoneNumber,
            placeHolder: 'Số điện thoại',
            toUserToPut: (text) => UserToPut(phoneNumber: text),
          ),
          InfoRowModel(
            Assets.icons.birthday,
            user?.birthday?.toVietNamese(),
            placeHolder: 'Ngày sinh',
            type: InfoRowType.dateTime,
            toUserToPut: (text) => UserToPut(
              birthday: DateTime.parse(text),
            ),
          ),
          InfoRowModel(
            Assets.icons.gender,
            user?.displayGender,
            placeHolder: 'Giới tính',
            enumData: Gender.getList(),
            enumValue: Gender.fromKey(user.gender),
            type: InfoRowType.enumable,
            toUserToPut: (text) => UserToPut(gender: text),
          ),
          InfoRowModel(
            Assets.icons.address,
            user?.address,
            placeHolder: 'Địa chỉ',
            toUserToPut: (text) => UserToPut(address: text),
          ),
        ]
            .where((e) => e.text.isExistAndNotEmpty || editMode)
            .map(
              (e) => InfoRow(
                data: e,
                editMode: editMode,
              ),
            )
            .toList(),
      ),
    );
  }
}
