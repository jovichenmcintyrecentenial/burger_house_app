import 'package:flutter/material.dart';

class AppBarClearColor extends StatelessWidget implements PreferredSizeWidget {
  const AppBarClearColor({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title??''),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
