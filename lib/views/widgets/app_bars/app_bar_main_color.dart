import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/app_theme.dart';

class AppBarMainColor extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const AppBarMainColor({
    Key? key,
    required this.title, this.actions,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      backgroundColor: AppTheme.of(context).primaryColorDark,
      elevation: 0,
      centerTitle: true, systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
