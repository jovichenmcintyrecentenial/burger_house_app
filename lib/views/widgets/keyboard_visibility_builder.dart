import 'package:flutter/material.dart';

import '../../utils/helper.dart';


class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget? child;
  final bool? shouldShowDone;
  final Widget Function(
    BuildContext context,
    Widget? child,
    bool isKeyboardVisible,
  ) builder;

  const KeyboardVisibilityBuilder({
    Key? key,
    this.child,
    required this.builder, this.shouldShowDone,
  }) : super(key: key);

  @override
  _KeyboardVisibilityBuilderState createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.builder(
          context,
          widget.child,
          _isKeyboardVisible,
        ),
        widget.shouldShowDone != null && widget.shouldShowDone!?Align(
            alignment: Alignment.bottomCenter,
            child: Visibility(
              visible: _isKeyboardVisible,
              child: Container(
                color: Colors.grey[200],
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Helper.hideKeyboard(context);
                          setState(() {
                            _isKeyboardVisible = false;
                          });
                        },
                        child: const Text('Done'))
                  ],
                ),
              ),
            )):const SizedBox(),
      ],
    );
  }
}
