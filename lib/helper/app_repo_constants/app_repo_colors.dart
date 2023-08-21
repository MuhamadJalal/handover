import 'package:flutter/material.dart';

class AppRepoColors {
  AppRepoColors._internal();

  static final AppRepoColors _instance = AppRepoColors._internal();

  factory AppRepoColors() => _instance;
  Color appPrimaryColor = const Color(0xffffb300); // #ffb300
  Color appAccentColor = const Color(0xffffe796); // #ffe796
  Color appOuterColor = const Color(0xff00c4de); // #00c4de
  Color appBlueColor = const Color(0xff4b4bff); // #4b4bff
  Color appGreyColor = const Color(0xffa3a4a5); // #a3a4a5
  Color appFontYellowColor = const Color(0xfff5d029); // #f5d029
  Color appFontBlackColor = const Color(0xff170038); // #170038
  Color appBlackColor = const Color(0xff1b0052); // #1b0052
  Color appLoaderBorderColor = const Color(0xff1b0052); // #1b0052
  Color appBackgroundColor = const Color(0xffE7E9ED); // #E7E9ED

  Color appRedColor = const Color(0xffe63f23);
  Color appWhiteColor = const Color(0xffffffff);
  Color appTransparentColor = Colors.transparent;
  Color kDialogColor = const Color.fromRGBO(215, 215, 215, 0.1);

  Color appFontWhiteColor = const Color(0xffffffff);
  Color appFontGreyColor = const Color(0xff4A494A);
  Color appFontGreenColor = const Color(0xff0ECB81);
  Color appFontRedColor = const Color(0xffe63f23);
}
