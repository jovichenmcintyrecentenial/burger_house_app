import 'dart:io';

import 'package:burger_house/views/widgets/dismissable_keyboard_container.dart';
import 'package:flutter/material.dart';

import '../app_bars/app_bar_main_color.dart';
import '../keyboard_visibility_builder.dart';

class ScaffoldMainAppBar extends StatelessWidget {
  final Widget? stackBottom;

  final Widget? leading;

  const ScaffoldMainAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.body,
    this.appBarColor, this.actions, this.shouldScroll = false, this.stackBottom, this.leading,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;
  final bool shouldScroll;
  final Color backgroundColor;
  final Color? appBarColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMainColor(title: title,actions:actions,leading: leading,),
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: !shouldScroll
          ? SafeArea(child: body)
          : SafeArea(
            child:  DismissableKeyboardContainer(
              child: KeyboardVisibilityBuilder(
                  shouldShowDone: Platform.isIOS,
                  builder: (context, snapshot,isVisible) {
                    return
                      Stack(
                        children: [
                          ListView(

                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                  child:body,
                                ),
                                const SizedBox(height: 20),


                              ],
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      stackBottom ?? const SizedBox(),
                                       const SizedBox(height: 20),

                                    ],
                                  ),
                                ))
                          ],
                      );
                  }
              ),
            )
      )
    );
  }
}
