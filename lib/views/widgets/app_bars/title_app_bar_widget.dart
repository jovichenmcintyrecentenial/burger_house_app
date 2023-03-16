import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  final String title;
  final Color? color;
  final bool hasLeading;

  const AppTitleBar(
      this.title, {
        super.key,
        this.color, this.hasLeading = false
      });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AutoTextSizeWidget(
        title,
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      backgroundColor:color?? AppTheme.of(context).primaryColor,
      centerTitle: true,
      leading: !hasLeading?SizedBox():null,
      elevation: 0,
    );
  }
}
