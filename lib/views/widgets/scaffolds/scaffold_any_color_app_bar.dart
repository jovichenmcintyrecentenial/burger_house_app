import 'package:flutter/material.dart';

import '../app_bars/app_bar_any_color.dart';

class ScaffoldAnyColorAppBar extends StatelessWidget {
  const ScaffoldAnyColorAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.body,
    required this.appBarColor,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final Color appBarColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAnyColor(
        title: title,
        color: appBarColor,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(child: body),
    );
  }
}
