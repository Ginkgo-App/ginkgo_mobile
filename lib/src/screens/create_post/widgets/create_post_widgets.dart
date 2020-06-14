library create_post_widgets;

import 'dart:io';

import 'package:base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ginkgo_mobile/src/models/fakeData.dart';
import 'package:ginkgo_mobile/src/models/models.dart';
import 'package:ginkgo_mobile/src/utils/designColor.dart';
import 'package:ginkgo_mobile/src/widgets/spacingRow.dart';
import 'package:ginkgo_mobile/src/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:base/base.dart';

part 'compose_bottom_icon_widget.dart';
part 'create_post_image.dart';
part 'create_post_image_list.dart';
part 'custom_app_bar.dart';
part 'custom_url_text.dart';
part 'title_text.dart';

Widget customIcon(
  BuildContext context, {
  int icon,
  bool isEnable = false,
  double size = 18,
  bool istwitterIcon = true,
  bool isFontAwesomeRegular = false,
  bool isFontAwesomeSolid = false,
  Color iconColor,
  double paddingIcon = 10,
}) {
  iconColor = iconColor ?? Theme.of(context).textTheme.caption.color;
  return Padding(
    padding: EdgeInsets.only(bottom: istwitterIcon ? paddingIcon : 0),
    child: Icon(
      IconData(icon,
          fontFamily: istwitterIcon
              ? 'TwitterIcon'
              : isFontAwesomeRegular
                  ? 'AwesomeRegular'
                  : isFontAwesomeSolid ? 'AwesomeSolid' : 'Fontello'),
      size: size,
      color: isEnable ? Theme.of(context).primaryColor : iconColor,
    ),
  );
}

Widget customText(String msg,
    {Key key,
    TextStyle style,
    TextAlign textAlign = TextAlign.justify,
    TextOverflow overflow = TextOverflow.visible,
    BuildContext context,
    bool softwrap = true}) {
  if (msg == null) {
    return SizedBox(
      height: 0,
      width: 0,
    );
  } else {
    if (context != null && style != null) {
      var fontSize =
          style.fontSize ?? Theme.of(context).textTheme.body1.fontSize;
      style = style.copyWith(
        fontSize: fontSize - (MediaQuery.of(context).size.width <= 375 ? 2 : 0),
      );
    }
    return Text(
      msg,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softwrap,
      key: key,
    );
  }
}

Widget customImage(
  BuildContext context,
  String path, {
  double height = 50,
  bool isBorder = false,
}) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade100, width: isBorder ? 2 : 0),
    ),
    child: CircleAvatar(
      maxRadius: height / 2,
      backgroundColor: Theme.of(context).cardColor,
      backgroundImage: CachedNetworkImageProvider(path),
    ),
  );
}

Widget customInkWell(
    {Widget child,
    BuildContext context,
    Function(bool, int) function1,
    Function onPressed,
    bool isEnable = false,
    int no = 0,
    Color color = Colors.transparent,
    Color splashColor,
    BorderRadius radius}) {
  if (splashColor == null) {
    splashColor = Theme.of(context).primaryColorLight;
  }
  if (radius == null) {
    radius = BorderRadius.circular(0);
  }
  return Material(
    color: color,
    child: InkWell(
      borderRadius: radius,
      onTap: () {
        if (function1 != null) {
          function1(isEnable, no);
        } else if (onPressed != null) {
          onPressed();
        }
      },
      splashColor: splashColor,
      child: child,
    ),
  );
}

class AppIcon {
  static final int fabTweet = 0xf029;
  static final int messageEmpty = 0xf187;
  static final int messageFill = 0xf554;
  static final int search = 0xf058;
  static final int searchFill = 0xf558;
  static final int notification = 0xf055;
  static final int notificationFill = 0xf019;
  static final int messageFab = 0xf053;
  static final int home = 0xf053;
  static final int homeFill = 0xF553;
  static final int heartEmpty = 0xf148;
  static final int heartFill = 0xf015;
  static final int settings = 0xf059;
  static final int adTheRate = 0xf064;
  static final int reply = 0xf151;
  static final int retweet = 0xf152;
  static final int image = 0xf109;
  static final int camera = 0xf110;
  static final int arrowDown = 0xf196;
  static final int blueTick = 0xf099;

  static final int link = 0xf098;
  static final int unFollow = 0xf097;
  static final int mute = 0xf101;
  static final int viewHidden = 0xf156;
  static final int block = 0xe609;
  static final int report = 0xf038;
  static final int pin = 0xf088;
  static final int delete = 0xf154;

  static final int profile = 0xf056;
  static final int lists = 0xf094;
  static final int bookmark = 0xf155;
  static final int moments = 0xf160;
  static final int twitterAds = 0xf504;
  static final int bulb = 0xf567;
  static final int newMessage = 0xf035;

  static final int sadFace = 0xf430;
  static final int bulbOn = 0xf066;
  static final int bulbOff = 0xf567;
  static final int follow = 0xf175;
  static final int thumbpinFill = 0xf003;
  static final int calender = 0xf203;
  static final int locationPin = 0xf031;
  static final int edit = 0xf112;
}
