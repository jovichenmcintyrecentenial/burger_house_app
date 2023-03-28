import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/utils/constants.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:burger_house/views/widgets/scaffolds/scaffold_main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ProcessingView extends StatelessWidget {

  static var routeName = "ProcessingView";
  final GenericArgs<SegueModel>? args;

  const ProcessingView({
    super.key, this.args,
  });

  String getLargeText(ProcessingViewProvider provider){

    switch (provider.state) {
      case ProcessingState.loading:
        return args!.param.onStartTitle;
      case ProcessingState.error:
        return args!.param.onFailTitle;
      case ProcessingState.success:
        return args!.param.onSuccessTitle;
      default:
        return '';
    }
  }

  String getSmallText(ProcessingViewProvider provider){

    switch (provider.state) {
      case ProcessingState.loading:
        return args!.param.onStart!;
      case ProcessingState.error:
        return args!.param.onFail!;
      case ProcessingState.success:
        return args!.param.onSuccess!;
      default:
        return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> ProcessingViewProvider(context,args),
      builder: (context, snapshot) {
        return Consumer<ProcessingViewProvider>(
          builder: (context, provider, snapshot) {
            return ScaffoldMainAppBar(
              leading:SizedBox(),
              title: args!.param.title!,
              backgroundColor: AppTheme.of(context).primaryColor,
              body:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child:
                        SizedBox(
                          height: 120,
                          width:120,
                          child: RiveAnimation.asset(
                            Images.loader,
                            controllers: [provider.controller],
                          ),
                        ),),
                    SizedBox(height: 30,),
                    AutoTextSizeWidget(getLargeText(provider), fontSize: 23,fontWeight: FontWeight.w600,),
                    SizedBox(height: 10,),
                    AutoTextSizeWidget(getSmallText(provider), textAlign:TextAlign.center,fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff7A7D86),maxLine: 2,),
                    SizedBox(height: 200,)
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



enum ProcessingState{error, loading, success}
class ProcessingViewProvider extends SegueNotifierViewProvider {

  RiveAnimationController controller = SimpleAnimation('loading');
  final GenericArgs<SegueModel>? args;
  final BuildContext context;
  ProcessingState state = ProcessingState.loading;

  ProcessingViewProvider(this.context,this.args,){
    args!.param.preProcessing(context);
    processSegue();
  }

  @override
  void startLoading() {
    state = ProcessingState.loading;
    controller = SimpleAnimation('loading');
  }

  void displaySuccess(){
    state = ProcessingState.success;
    controller = SimpleAnimation('success');
  }

  void displayError(){
    state = ProcessingState.error;
    controller = SimpleAnimation('error');
  }

  void processSegue() {
    args!.param.apiRequest!().then((_){
      displaySuccess();
      Future.delayed(Duration(seconds: 4), () {
        args!.param.onComplete(context);
      });
    }).onError((__,_){
      displayError();
    }).whenComplete((){
      notifyListenersSafe();

    });
  }


  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }
}