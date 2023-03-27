import 'package:burger_house/data/models/response_model/places_api_response.dart';
import 'package:burger_house/models/address.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/providers/payment_bottom_sheet_provider.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/empty_list_widget/empty_payment_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentBottomSheet extends StatelessWidget {
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 47),
                    child: Stack(
                      children: [
                        provider.pageState==PPageState.addNewPayment?
                        Consumer<PaymentBottomSheetProvider>(
                            builder: (context, provider ,snapshot) {
                              return Container(
                                color:Colors.green,
                                child: Column(
                                  children: [
                                    AppTitleBar('',color:Colors.transparent),
                                    AppTitleBar('',color:Colors.transparent,
                                      actions: [_CloseButton()],),
                                    InputWidget(
                                        title: 'Search for your address',
                                        autoFocus: true,
                                        fontSize:17,
                                        onChangeText: provider
                                            .onChangeSearch),
                                    SizedBox(height: 10,),
                                    Expanded(
                                      child: StreamListeningWidget(
                                        streamName: Strings.searchNotification,
                                        builder: (context,PlaceApiResponse? placeApiResponse) {

                                          return Container(
                                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: placeApiResponse?.results?.length??0,
                                              itemBuilder: (BuildContext context, int index) {
                                                var result = placeApiResponse
                                                    ?.results![index];
                                                return Container(
                                                  constraints: BoxConstraints(
                                                    minHeight: 70,
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 13,vertical: 14),
                                                  margin: EdgeInsets.only(bottom: 1),
                                                  decoration: BoxDecoration(
                                                      color:AppTheme.of(context).primaryColorLight
                                                      ,borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child: LocationsListItem(
                                                    result,
                                                    onTap: () {
                                                      provider
                                                          .selectedAddress(result!);
                                                    },
                                                  ),
                                                );
                                              },

                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                        )
                            :Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10,),
                            AppTitleBar('Payment Methods',color: Colors.transparent,fontWeight:FontWeight.w600),
                            provider.isLoading?
                            CircularProgressIndicator()
                                :
                            !provider.cards.isEmpty
                                ? _ListOfAddresses()
                                : EmptyPaymentWiget(),
                            Row(
                              children: [
                                Flexible(
                                    child: MediumButtonWidget(
                                      'Add New Card',
                                      hasShadow: false,
                                      onTap: () {
                                        provider.updateState(PPageState.addNewPayment);
                                      },
                                    )),
                                SizedBox(width: 20,),
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
                            SafeArea(child: const SizedBox(height: 40,)),

                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
          );
        }
    );
  }
}

class _ListOfAddresses extends StatelessWidget {
  const _ListOfAddresses({
    super.key,
  });

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
              return AddressListItemDark(
                address: address,
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

class AddressListItemDark extends StatelessWidget {
  final Function() onDismissed;

  const AddressListItemDark({
    super.key,
    required this.address, required this.onDismissed,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context,address);
      },
      child: Column(
        children: [
          Dismissible(
            key: Key(address.id!),
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
                  minHeight: 70,
                ),
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 10,right:10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color:AppTheme.of(context).primaryColorDark
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    GenericImagehandler(Images.mapPinIcon),
                    SizedBox(width: 13,),
                    Flexible(child: AutoTextSizeWidget(address.address!,maxLine: 2,)),
                  ],
                )),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class LocationsListItem extends StatelessWidget {

  final Result? result;
  final Function() onTap;

  const LocationsListItem(
      this.result,
      {required this.onTap,
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Row(
        children: [
          GenericImagehandler(Images.mapPinIcon),
          SizedBox(width:10),
          Expanded(
            child: AutoTextSizeWidget(
              result?.formattedAddress ??
                  '',maxLine: 3,fontSize: 15,),
          ),
        ],
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentBottomSheetProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          provider.updateState(PPageState.viewPayments);
        },
        child: AutoTextSizeWidget('Close'),
      ),
    );
  }
}

enum PPageState { addNewPayment, viewPayments}

