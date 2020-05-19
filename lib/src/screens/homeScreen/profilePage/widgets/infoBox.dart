import 'package:base/base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/assets.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:intl/intl.dart';

class InfoBox extends StatelessWidget {
  final User user;

  const InfoBox({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: Assets.icons.resume,
      title: 'Thông tin cá nhân',
      child: Column(
        children: <Widget>[
          _buildRow(Assets.icons.job, user?.job),
          _buildRow(Assets.icons.email, user?.email),
          _buildRow(Assets.icons.phone, user?.phoneNumber),
          _buildRow(
              Assets.icons.birthday,
              user.birthday != null
                  ? DateFormat('dd/MM/yyyy').format(user.birthday)
                  : ''),
          _buildRow(Assets.icons.gender, user?.displayGender),
          _buildRow(Assets.icons.address, user?.address),
        ],
      ),
    );
  }

  Widget _buildRow(String icon, String text) {
    return text.isExistAndNotEmpty
        ? Container(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 15),
                    child: SvgPicture.asset(icon, height: 20)),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 2, 0, 10),
                    decoration: new BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ))),
                    child: Text(text),
                  ),
                )
              ],
            ))
        : const SizedBox.shrink();
  }
}
