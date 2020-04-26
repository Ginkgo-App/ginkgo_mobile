import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/imageFiles.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';

class FakeUser {
  static final infoPersonal = [
    User(
      fullName: "Nguyễn Trung Nguyên",
      job: "ăn không ngồi rồi",
      email: "16520848@gm.uit.edu.vn",
      phoneNumber: "0123456789",
      birthday: DateTime(1998, 06, 11),
      gender: Gender.male,
      address: "sai gon",
    ),
    User(
      fullName: "Lê Hồng Hiển",
      job: "Master Flutter",
      email: "16520361@gm.uit.edu.vn",
      phoneNumber: "0987654321",
      birthday: DateTime(1998, 03, 15),
      gender: Gender.male,
      address: "sai gon",
    )
  ];
}

class InfoBox extends StatelessWidget {
  final User user;

  const InfoBox({Key key, this.user}) : super(key: key);

  Widget _buildRow(String icon, String text) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 5, right: 15),
                child: Image.asset(icon)),
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      icon: ImageFiles.icon.resume,
      title: 'Thông tin cá nhân',
      child: Column(
        children: <Widget>[
          _buildRow("assets/icons/job.png", "Travel Bloger"),
          _buildRow("assets/icons/email.png", "baymax@samplemail"),
          _buildRow("assets/icons/phone.png", "0123456789 "),
          _buildRow("assets/icons/birthday.png", "01/01/1998"),
          _buildRow("assets/icons/gender.png", "Nam"),
          _buildRow("assets/icons/address.png", "suối tiên"),
        ],
      ),
    );
  }
}
