import 'package:flutter/cupertino.dart';


class FadingVisibility extends StatelessWidget {
  const FadingVisibility({
    Key? key,
    required this.child,
    required this.visible,
  }) : super(key: key);

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: visible ? 0 : 1,
        duration: Duration(milliseconds: visible ? 0 : 250),
        // visible: !isKeyboardVisible,
        child: !visible ? child : const SizedBox());
  }
}
