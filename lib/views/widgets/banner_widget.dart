//@dart=2.12
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/generic_Image_handler.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';



class BannerMessageWidget extends StatelessWidget {
  final String message;
  final BannerConfig? config;
  final MessageType? messageType;

  const BannerMessageWidget(
      {Key? key, required this.message,
       this.config,
      this.messageType = MessageType.error}) : super(key: key);

  bool _isMessageSingleLine(bannerTextStyle,constraints){
    final textPainter1 = TextPainter(
      text: TextSpan(
        text: message.toLowerCase(),
        style: bannerTextStyle,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    textPainter1.layout(maxWidth: constraints.maxWidth);

    if(!textPainter1.didExceedMaxLines){
      return true;
    }
   return false;
  }

  @override
  Widget build(BuildContext context) {
    var statusBar = MediaQuery.of(context).viewPadding.top;
    // var bannerConfig = config ?? BannerConfig();
    final bannerTextStyle = TextStyle(
        color: getTextColor(),
        fontFamily: FontFamily.poppins,
        fontSize: 15.5,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none
    );


    return LayoutBuilder(
      builder: (context,constraints) {
        final isSingleLineMessage  = _isMessageSingleLine(bannerTextStyle,constraints);

        return Container(width: double.infinity,
          decoration: BoxDecoration(
              color: backgroundColor(), borderRadius: BorderRadius.circular(0),
          ),
          margin: EdgeInsets.only(top:statusBar,left: 0,right: 0,bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: Row(
            crossAxisAlignment: isSingleLineMessage
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              const SizedBox(width:6),
              Column(
                children: [
                  SizedBox(height: isSingleLineMessage?0:3),
                  GenericImagehandler(getImage(), width: 24,height: 24),
                ],
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    const SizedBox(width:12),
                    Expanded(
                      child: Text(
                        message,
                        style: bannerTextStyle,)
                    ),
                    const SizedBox(width:12),

                    Center(
                      child: GestureDetector(
                          onTap: () => OverlaySupportEntry.of(context)!.dismiss(),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: GenericImagehandler(Images.closeIcon,
                                  width: 24, height: 24),
                            ),
                          )),
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Color getTextColor() {

    return Colors.white;
  }

  Color outlineColor() {
    if(messageType == MessageType.success) {
      return const Color(0xff9BD9C5);
    }
    return const Color(0xff7E3A38);
  }

  Color backgroundColor() {
    if(messageType == MessageType.success) {
      return const Color(0xff2b4830);
    }
    if(messageType == MessageType.info) {
      return const Color(0xff2b3448);
    }
    return const Color(0xff482b2b);
  }

  String getImage() {

    if(messageType == MessageType.success) {
      return Images.successIcon;
    }
    if(messageType == MessageType.info) {
      return Images.infoIcon;
    }

    return Images.errorIcon;
  }
}

enum MessageType { info, error, success }

class BannerConfig {
}
