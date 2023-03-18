import 'package:burger_house/data/models/response_model/places_api_response.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/pages/order_confirmation/bottom_sheets/providers/address_bottom_sheet_provider.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/empty_address_widget/empty_address_widget.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:burger_house/views/widgets/input_widget.dart';
import 'package:burger_house/views/widgets/main_button_widget.dart';
import 'package:burger_house/views/widgets/stream_listner_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create:(_) => AddressBottomSheetProvider(),
      builder: (context, snapshot) {
        return Consumer<AddressBottomSheetProvider>(
          builder: (context, provider, snapshot) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: provider.pageState != PageState.locationSearch
                    ? AppTheme.of(context).primaryColorLight
                    : Colors.black.withOpacity(.7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 47),
                child: Stack(
                  children: [

                    provider.pageState==PageState.locationSearch?
                    Consumer<AddressBottomSheetProvider>(
                        builder: (context, provider ,snapshot) {
                          return Column(
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
                                                child: Row(
                                                  children: [
                                                    GenericImagehandler(Images.mapPinIcon),
                                                    SizedBox(width:10),
                                                    Expanded(
                                                      child: AutoTextSizeWidget(
                                                          placeApiResponse
                                                                  ?.results![index]
                                                                  .formattedAddress ??
                                                              '',maxLine: 3,fontSize: 15,),
                                                    ),
                                                  ],
                                                ));
                                          },

                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                    )
                    :Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10,),
                        AppTitleBar('Delivery Address',color: Colors.transparent,fontWeight:FontWeight.w600),
                        EmptyAddressWiget(),
                        Row(
                          children: [
                            Flexible(
                                child: MediumButtonWidget(
                                  'Add New Address',
                                  hasShadow: false,
                                  onTap: () {
                                      provider.updateState(PageState.locationSearch);
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

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressBottomSheetProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: () {
                provider.updateState(PageState.viewAddress);
              },
              child: AutoTextSizeWidget('Close'),
            ),
          );
  }
}

enum PageState { locationSearch, viewAddress}

