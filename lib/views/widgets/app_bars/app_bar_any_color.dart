import 'package:flutter/material.dart';

class AppBarAnyColor extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAnyColor({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: color,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
