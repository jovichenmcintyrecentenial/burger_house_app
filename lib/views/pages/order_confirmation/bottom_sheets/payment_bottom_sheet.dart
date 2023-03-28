import 'package:burger_house/data/models/response_model/card_response.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/providers/payment_bottom_sheet_provider.dart';
import 'package:burger_house/views/widgets/add_a_card_widget.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/empty_list_widget/empty_payment_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentBottomSheet extends StatelessWidget{
  const PaymentBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create:(_) => PaymentBottomSheetProvider(),
        builder: (context, snapshot) {
          return Consumer<PaymentBottomSheetProvider>(
              builder: (context, provider, snapshot) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: provider.pageState != PPageState.addNewPayment
                        ? AppTheme.of(context).primaryColorLight
                        : Colors.black.withOpacity(.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      provider.pageState==PPageState.addNewPayment? Consumer<PaymentBottomSheetProvider>(
                          builder: (context, provider, snapshot) {
                          return AddCardWidget();
                        })
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              AppTitleBar('Payment Methods',
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.w600),
                              provider.isLoading
                                  ? CircularProgressIndicator()
                                  : !provider.cards.isEmpty
                                      ? _ListOfCards()
                                      : EmptyPaymentWiget(),
                              Row(
                                children: [
                                  Flexible(
                                      child: MediumButtonWidget(
                                    'Add New Card',
                                    hasShadow: false,
                                    onTap: () {
                                      provider.updateState(
                                          PPageState.addNewPayment);
                                    },
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                      child: MediumButtonWidget(
                                    'Go Back',
                                    isSecondaryButton: true,
                                    hasShadow: false,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  )),
                                ],
                              ),
                              SafeArea(
                                  child: const SizedBox(
                                height: 40,
                              )),
                            ],
                          ),
                      )
                ],
                  ),
                );
              }
          );
        }
    );
  }
}


class _ListOfCards extends StatelessWidget {
  const _ListOfCards();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentBottomSheetProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        AutoTextSizeWidget('Cards',color:Color(0xff7A7D86),fontSize: 15,),
        SizedBox(height: 15,),
        Flexible(
          child: ListView.builder(
            itemCount: provider.cards.length,
            shrinkWrap: true,
            itemBuilder:
                (BuildContext context, int index) {
              var address = provider.cards[index];
              return CardListItem(
                card: address,
                onDismissed: ()=>provider.removeItem(index),
              );
            },
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}

class CardListItem extends StatelessWidget {
  final Function() onDismissed;

  const CardListItem({
    super.key,
    required this.card, required this.onDismissed,
  });

  final CardResponse card;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context,card);
      },
      child: Column(
        children: [
          Dismissible(
            key: Key(card.id!),
            direction: DismissDirection.endToStart, // Only allow swiping from right to left
            background: Container(
              padding: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffd24242),
              ),
              child: Icon(Icons.delete,color: Colors.white,),
              alignment: Alignment.centerRight,
            ),
            onDismissed: (_)=>onDismissed(),
            child: Container(
                constraints: BoxConstraints(
                  minHeight: 80,
                ),
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right:10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color:AppTheme.of(context).primaryColorDark
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    GenericImagehandler(Images.cardLogo,width: 55,),
                    SizedBox(width: 30,),
                    Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoTextSizeWidget(
                      "****  *****  ****  " +
                              card.cardNumber!.substring(
                                  card.cardNumber!.length - 4,
                                  card.cardNumber!.length),
                          fontSize: 18,
                          maxLine: 1,
                        ),
                            Row(
                              children: [
                                AutoTextSizeWidget(card.cardDate!,color:Color(0xff7A7D86),fontSize: 18),
                                Spacer(),
                                AutoTextSizeWidget(card.cvv.toString(),color:Color(0xff7A7D86),fontSize: 18),
                                SizedBox(width:65,)
                              ],
                            )
                          ],
                        )),
                  ],
                )),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

enum PPageState { addNewPayment, viewPayments}

