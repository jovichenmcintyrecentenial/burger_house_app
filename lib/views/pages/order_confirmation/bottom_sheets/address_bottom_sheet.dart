import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/empty_address_widget/empty_address_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:flutter/material.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 47),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            AppTitleBar('Delivery Address',color: Colors.transparent,fontWeight:FontWeight.w600),
            EmptyAddressWiget(),
            Row(
              children: [
                Flexible(child: MediumButtonWidget('Add New Address',hasShadow:false,onTap: (){},)),
                SizedBox(width: 20,),
                Flexible(child: MediumButtonWidget('Go Back',isSecondaryButton: true,hasShadow:false,onTap: (){},)),
              ],
            ),
            SafeArea(child: const SizedBox(height: 40,)),

          ],
        ),
      ),
    );
  }
}

