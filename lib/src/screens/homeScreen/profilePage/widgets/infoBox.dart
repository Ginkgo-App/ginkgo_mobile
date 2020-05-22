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
          _ItemData(Assets.icons.job, user?.job, 'Nghề nghiệp'),
          _ItemData(Assets.icons.email, user?.email, 'Email'),
          _ItemData(Assets.icons.phone, user?.phoneNumber, 'Số điện thoại'),
          _ItemData(Assets.icons.birthday, user?.birthday?.toVietNamese(), 'Ngày sinh'),
          _ItemData(Assets.icons.gender, user?.displayGender, 'Giới tính'),
          _ItemData(Assets.icons.address, user?.address, 'Địa chỉ'),
        ]
            .where((e) => e.text.isExistAndNotEmpty || editMode)
            .map(
              (e) => InfoRow(
                svgIcon: e.svgIcon,
                text: e.text,
                placeHolder: e.placeHolder,
                editMode: editMode,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ItemData {
  final String svgIcon;
  final String text;
  final String placeHolder;

  _ItemData(this.svgIcon, this.text, this.placeHolder);
}
