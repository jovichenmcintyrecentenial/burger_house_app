import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/widgets.dart';

class EmptyPaymentWiget extends StatelessWidget {
  const EmptyPaymentWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        GenericImagehandler(Images.noPaymentIcon,width: 114,height: 114,),
        SizedBox(height: 15,),
        AutoTextSizeWidget('No Card added as yet',fontSize: 17,),
        AutoTextSizeWidget(
          'To add a new Card tap\n“Add New Card”',
          fontSize: 16,
          maxLine: 2,
          textAlign: TextAlign.center,
          color: Color(0xff7A7D86),
        ),
        SizedBox(height: 50,),
      ],
    );
  }
}
