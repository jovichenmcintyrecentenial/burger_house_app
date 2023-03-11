import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [ BoxShadow(
            color: Colors.black.withOpacity(0.2), // background color
            spreadRadius: 3,
            blurRadius: 4.0,
            offset: -Offset(-1,-3),

          ),],
        ),
        child: GenericImagehandler(
          Images.cartButtonIcon,
          width: 60,
          height: 60,
        ));
  }
}
