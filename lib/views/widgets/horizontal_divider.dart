
import 'package:burger_house/theme/app_theme.dart';
import 'package:flutter/widgets.dart';

import '../../utils/helper.dart';

class HorizontalDivider extends StatelessWidget {
  final double fixSpace;
  final color;
  final double thickness;
  final double spaceBasedOnWidthPercentage;

  final EdgeInsets? padding;

  HorizontalDivider(
      {Key? key,
        this.fixSpace = 0.0,
        this.color,
        this.spaceBasedOnWidthPercentage = 0.0,
        this.thickness = 1.0, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding??EdgeInsets.all(0),
      child: Row(
        children: [
          SizedBox(
            width: Helper.getScaleWidthPercentage(
                context, spaceBasedOnWidthPercentage),
          ),
          SizedBox(
            width: fixSpace,
          ),
          Expanded(
              child: Container(
                  height: thickness,
                  color: color ?? AppTheme.of(context).primaryColorDark)),
        ],
      ),
    );
  }
}
