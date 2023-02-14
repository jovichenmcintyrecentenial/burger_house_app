import 'package:flutter/material.dart';

import '../app_bars/app_bar_clear_color.dart';

class ScaffoldClearAppBar extends StatelessWidget {
  const ScaffoldClearAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.body,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarClearColor(title: title),
      backgroundColor: backgroundColor,
      body: body,
    );
  }
}
