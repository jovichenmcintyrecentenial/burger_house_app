import 'package:burger_house/models/mixins/validator_mixin.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/formatters/credit_card_date_formatter.dart';
import 'package:burger_house/utils/formatters/credit_card_text_formatter.dart';
import 'package:burger_house/utils/formatters/cvv_text_formatter.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/payment_bottom_sheet.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/providers/payment_bottom_sheet_provider.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddCardWidget extends StatelessWidget with ValidatorMixin<PaymentBottomSheetProvider>{
  const AddCardWidget({
    super.key,
  });

  @override
  void onSuccessValidation(BuildContext context, {String? routeName, PaymentBottomSheetProvider? provider, GenericArgs? args}) {
    provider!.saveCard();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PaymentBottomSheetProvider>(context);
    return Container(
      padding: EdgeInsets.only(left: 30,right: 30),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
          color: AppTheme.of(context).primaryColorLight
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: .0, vertical: 10),
            child: AppTitleBar(
              'Add a Card',
              color: Colors.transparent,
            ),
          ),
          SubTitleWidget('Add Card'),
          const SizedBox(height: 20),
          InputWidget(
            title: 'Card Number',
            autoFocus: true,
            fontSize: 17,
            color: AppTheme.of(context).primaryColorDark,
            inputFormatter: CreditCardFormatter(),
            onChangeText: (text) => provider.cardNumber = text,
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: InputWidget(
                    title: 'Expiry Date',
                    autoFocus: false,
                    fontSize: 17,
                    color: AppTheme.of(context).primaryColorDark,
                    inputFormatter: CreditCardDateFormatter(),
                    onChangeText: (text) => provider.dateText = text,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InputWidget(
                    title: 'CVV',
                    autoFocus: false,
                    fontSize: 17,
                    color: AppTheme.of(context).primaryColorDark,
                    inputFormatter: CreditCardCVVFormatter(),
                    onChangeText: (text) => provider.cvv = text,
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(height:20,),
          const SizedBox(height:20,),
          Flexible(
            child: Row(
              children: [
                Flexible(
                    child: MediumButtonWidget(
                        'Save Card',
                        hasShadow: false,
                        onTap: ()=> onValidate(context, provider,null,routeName: null,shouldHideKeyboard: false)


                    )),
                SizedBox(width: 20,),
                Flexible(
                    child: MediumButtonWidget(
                      'Go Back',
                      isSecondaryButton: true,
                      hasShadow: false,
                      onTap: () {
                        provider.updateState(PPageState.viewPayments);
                      },
                    )),
              ],
            ),
          ),
          const SizedBox(height:20,),
          const SizedBox(height:20,),
        ],
      ),
    );
  }
}
