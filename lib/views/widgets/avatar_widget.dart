
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'generic_Image_handler.dart';

class AvtarWidget extends StatelessWidget {
  const AvtarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.all(4),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: const Color(0xff363031),
          borderRadius: BorderRadius.circular(100)),
      child: const GenericImagehandler(Images.tempAvatar,width: double.infinity,height: double.infinity,),
    );
  }
}