import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/views/pages/main_view/main_manager_view.dart';
import 'package:flutter/material.dart';

enum SegueType {
  transaction,
  order,
  other,
}

abstract class SegueModel {
  ///Title displayed in app bar to user
  String? title;

  String onStartTitle = 'Processing';
  String onSuccessTitle = 'Success';
  String onFailTitle = 'Error';

  ///Message to display to user when apiRequest Future starts
  String? onStart;
  ///Message to display to user when apiRequest Future is successful
  String? onSuccess;
  ///Message to display to user when apiRequest Future throw an error
  String? onFail;
  ///Message to display to user when apiRequest Future throw an error
  String? onFailMessage;
  ///An future call that you want to be run on GenericProcessing Screen here
  dynamic apiRequest;
  ///set this when you want onFail state to Navigator pop to previous page
  /// if apiRequest is an Instant of FailRequest you can force a fail render on UI
  String? positiveButtonTitle;


  Function(BuildContext)? positiveAction;
  Function(BuildContext)? negativeAction;



  List<String> continueOnError = [];

  String text1 = '';
  String text2 = '';
  String text3 = '';
  String text4 = '';

  String? image;
  var type = SegueType.transaction;
  var customTypeMessage;

  var secondDelayAfterComplete = 3;

  ///action that happen on a successful apiRequest
  void onComplete(BuildContext context) {
    Navigator.popUntil(context, (route) {
      return MainManagerView.routeName == route.settings.name ||
          '/' == route.settings.name || route.settings.name == null;
    });

  }
  ///Override this method so that Generic Processing View can call
  /// Consider setting the below variable to make this work correctly
  ///
  ///  String title;
  ///
  ///   String onStart;
  ///
  ///   String onSuccess;
  ///
  ///   String onFail;
  ///
  ///   String onFailMessage;
  ///
  ///   dynamic apiRequest;
  ///
  void preProcessing(BuildContext context) {
    UnimplementedError('implement this function');
  }
}

@Deprecated('use SegueNotifierViewProvider instead')
abstract class SegueViewProvider<T> {
  Function? onDispose;

  bool isOk(BuildContext context, {GenericArgs<T> args});

  void updateSegueObject({GenericArgs<T> args});

}

abstract class BaseViewModel{

  Function? notifyListener;
  Function? startLoading;
  Function? stopLoading;
  bool isDisposed = false;

  //initial stuff here instead of
  void initialize(){}


}

abstract class SegueNotifierViewProviderViewModel<T,K extends BaseViewModel> extends SegueNotifierViewProvider<T>{
  late K _viewModel;

  void setViewModel(K viewModel ){
    _viewModel = viewModel;
    _viewModel.startLoading = startLoading;
    _viewModel.stopLoading = stopLoading;
    _viewModel.notifyListener = notifyListenersSafe;
    _viewModel.initialize();
  }

  K getViewModel(){
    return _viewModel;
  }

  @override
  void dispose() {
      _viewModel.startLoading = null;
      _viewModel.stopLoading = null;
      _viewModel.notifyListener = null;
      super.dispose();
      _viewModel.isDisposed = true;
  }

}

abstract class SegueNotifierViewProvider<T> extends ChangeNotifier{

  Function? onDispose;
  var isDisposed = false;

  var isLoading = false;

  //@protected
  void stopLoading(){
    isLoading = false;
    notifyListenersSafe();
  }

  //@protected
  void startLoading(){
    isLoading = true;
    notifyListenersSafe();
  }

  void notifyListenersSafe(){
    if(!isDisposed){
      notifyListeners();
    }
  }

  bool isOk(BuildContext context, {GenericArgs<T>? args});

  void updateSegueObject({GenericArgs<T>? args});

  @override
  void dispose() {
    if(onDispose != null){
      onDispose!();
    }

    isDisposed = true;
    super.dispose();


  }

}
