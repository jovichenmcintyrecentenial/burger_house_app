import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/material.dart';

class AppTitleBar extends StatelessWidget {
  final String title;

  const AppTitleBar(
      this.title, {
        super.key,
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
      backgroundColor: AppTheme.of(context).primaryColor,
      centerTitle: true,
      leading: SizedBox(),
      elevation: 0,
    );
  }
}
