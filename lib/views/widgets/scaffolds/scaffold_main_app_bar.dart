import 'dart:io';

import 'package:burger_house/utils/helper.dart';
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
    this.appBarColor, this.actions, this.shouldScroll = false, this.stackBottom, this.expandedContainer = false,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;
  final bool shouldScroll;
  final bool expandedContainer;
  final Color backgroundColor;
  final Color? appBarColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMainColor(title: title,actions:actions),
      backgroundColor: backgroundColor,
      body: !shouldScroll
          ? SafeArea(child: body)
          : SafeArea(
            child:  KeyboardVisibilityBuilder(
                shouldShowDone: Platform.isIOS,
                builder: (context, snapshot,isVisible) {
                  return Stack(
                    children: [
                      !expandedContainer?
                      ListView(
                        children: [
                          SizedBox(
                            height: Helper.availableContentHeight(context,
                                shrinkOnKeyboardVisible: true)+Helper.getScaleHeightPercentage(context, 10),
                            child: Container(child: body),
                          )
                        ],
                      ):SizedBox(
                        height: double.infinity,
                        child: body,
                      ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: FadingVisibility(
                                  child: stackBottom ?? const SizedBox(),
                                  visible: isVisible))
                        ],
                  );
                }
            )
      )
    );
  }
}
