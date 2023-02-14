import 'dart:io';

import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/widgets/dismissable_keyboard_container.dart';
import 'package:flutter/material.dart';

import '../app_bars/app_bar_main_color.dart';
import '../fading_visibility.dart';
import '../keyboard_visibility_builder.dart';

class ScaffoldMainAppBar extends StatelessWidget {
  final Widget? stackBottom;

  const ScaffoldMainAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.body,
    this.appBarColor, this.actions, this.shouldScroll = false, this.stackBottom,
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
      appBar: AppBarMainColor(title: title,actions:actions),
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
                                      Container(
                                        color: Colors.green,
                                        height: 10,
                                        width: 10,
                                      ),
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
