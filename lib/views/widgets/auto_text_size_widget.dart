import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';

import '../../theme/app_theme.dart';

class AutoTextSizeWidget extends StatelessWidget {
  final FontWeight? fontWeight;

  final double? fontSize;
  final Color? color;

  final int maxLine;

  final TextAlign textAlign;

  final bool isUnderline;

  final String? fontFamily;

  final TextOverflow? overflow;

  final double? height;

  const AutoTextSizeWidget(
      this.title,

      {Key? key,
        this.color,
        this.fontWeight,
        this.fontSize = 17.0,
        this.fontFamily,
        this.maxLine = 1,
        this.textAlign = TextAlign.left,
        this.overflow,
        this.isUnderline = false, this.height})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return overflow == null?AutoSizeText(
      title,
      maxLines: maxLine,
      minFontSize: 1,
      textAlign: textAlign,
      style: AppTheme.of(context).mainColorRowFontStyle!.copyWith(
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: height,
          fontFamily: fontFamily,
          decoration: isUnderline?TextDecoration.underline: TextDecoration.none,
          color: color ?? AppTheme.of(context).mainFontColor),
    ):Text(
      title,
      maxLines: maxLine,
      overflow: overflow,
      textAlign: textAlign,
      style: AppTheme.of(context).mainColorRowFontStyle!.copyWith(
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: height,
          fontFamily: fontFamily,
          decoration: isUnderline?TextDecoration.underline: TextDecoration.none,
          color: color ?? AppTheme.of(context).mainFontColor),
    );
  }
}