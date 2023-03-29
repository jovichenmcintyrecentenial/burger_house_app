import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/main_view/providers/main_manager_view_provider.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:flutter/widgets.dart';

class EmptyOrderWidget extends StatelessWidget {
  const EmptyOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: GenericImagehandler(Images.bagWithLogo,width: 212,fit: BoxFit.fill,)),
          SizedBox(height: 30,),
          AutoTextSizeWidget('No Order.',color:Color(0xffE1E3EB),fontSize: 20,fontWeight: FontWeight.w600,),
          AutoTextSizeWidget(
            'When you add items to your cart, they will appear here',
            fontSize: 15,
            color: Color(0xff7A7D86),
            textAlign: TextAlign.center,
            maxLine: 2,
          ),
          SizedBox(height: 20,),
          MainButtonWidget('Review Cart', onTap: (){
            MainManagerProvider.stream.add(3);

          }),
          SizedBox(height: 60,),

        ],
      ),
    );
  }
}
