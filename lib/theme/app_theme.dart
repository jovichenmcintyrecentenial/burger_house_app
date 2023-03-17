import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fonts.dart';
import 'provider/theme_provider.dart';

class AppTheme {
  TextStyle? lightColorRowFontStyle;
  TextStyle? mainColorRowFontStyle;
  TextStyle? accentColorRowFontStyle;

  static AppTheme of(BuildContext context) {
    return Provider.of<ThemeProvider>(context).theme;
  }

  Color primaryColorLight = const Color(0xff363031);
  Color primaryColorLighter = const Color(0xff555555);
  Color primaryColor = const Color(0xff231F20);
  Color primaryColorDark = const Color(0xff231F20);
  Color keyPadColor = const Color(0xFFF8F8F8);
  Color accentColor = const Color(0xFFDF933B);
  Color mainAppColor = Colors.blue;
  Color failViewColor = const Color(0xFF344058);

  Color mainFontColor = const Color(0xFFE1E3EB);
  Color mainFontColor2 = const Color(0xffFFFFFF);
  Color mainFontColor3 = const Color(0xffA9A9A9);
  Color lightFontColor = const Color(0xffFFFFFF);

  Color textFieldBackgroundColor = const Color(0xff2A2A2A);
  Color borderColor = const Color(0xffCDCEE1);
  Color hintFontColor = const Color(0xff7F7F7F);


  Color accentFontColor = const Color(0xff00683C);

  double buttonFontSize = 16;

  AppTheme() {
    headline7 = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w300,
      color: mainFontColor,
    );
    mainColorRowFontStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: mainFontColor,
    );

    lightColorRowFontStyle = const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w300,
      color: Colors.grey,
    );

    accentColorRowFontStyle = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w300,
      color: accentColor,
    );
  }

  var defaultFont = FontFamily.Poppins;

  var bodyText1 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var overline = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var bodyText2 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var caption = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var button = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var headline1 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var headline2 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var headline3 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var headline4 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var headline5 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var headline7 = const TextStyle(
    fontSize: 17.0,
    fontWeight: FontWeight.w700,
    color: Colors.grey,
  );
  var subtitle1 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  var subtitle2 = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );


}
