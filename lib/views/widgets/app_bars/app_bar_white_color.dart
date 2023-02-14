import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

class AppBarWhiteColor extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWhiteColor({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return AppBar(
      iconTheme: IconThemeData(
        color: AppTheme.of(context).mainFontColor, //change your color here
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppTheme.of(context).mainFontColor,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
