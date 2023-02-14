import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class AppBarMainColor extends StatelessWidget implements PreferredSizeWidget {
  final actions;

  const AppBarMainColor({
    Key? key,
    @required this.title, this.actions,
  }) : super(key: key);
  final title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      backgroundColor: AppTheme.of(context).primaryColorLight,
      brightness: Brightness.dark,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
