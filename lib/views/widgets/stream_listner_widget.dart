import 'dart:async';

import 'package:flutter/cupertino.dart';

class StreamObject <T> {

  final T object;
  final name;

  StreamObject({required this.name,required this.object});

}

class StreamListeningWidget <T> extends StatefulWidget{
  final String streamName;
  final  builder;
  final T? defaultValue;

  const StreamListeningWidget(
      {Key? key, required this.streamName, @required this.builder, this.defaultValue})
      : super(key: key);

  static void trigger(StreamObject object) {
    StreamListeningSetTypeWidget.stream.add(object);
  }

  static void listen<T>(
      {
        required String streamName,
        required bool Function() isDisposed,
        required Function(dynamic) onTrigger
      }) {
    var subscriber;

    subscriber = StreamListeningSetTypeWidget.stream.stream.listen((dynamic action) {
      if(action is StreamObject){
        if (isDisposed()) {
          subscriber.cancel();
          return;
        }
        if(action.name == streamName){
          onTrigger(action.object);
        }
      }

    });
  }

  @override
  State<StreamListeningWidget<T>> createState() => _StreamListeningWidgetState<T>();
}

class _StreamListeningWidgetState<T> extends State<StreamListeningWidget<T>> {
    @override
  Widget build(BuildContext context) {
    return StreamListeningSetTypeWidget<T,Widget>(streamName:widget.streamName,builder:widget.builder,defaultValue:widget.defaultValue);
  }
}

class StreamListeningSetTypeWidget <T,K> extends StatefulWidget {


  static StreamController stream = StreamController<StreamObject>.broadcast();
  final String streamName;
  final  builder;

  final T? defaultValue;

  static void trigger(StreamObject object){
    StreamListeningSetTypeWidget.stream.add(object);
  }



  const StreamListeningSetTypeWidget(
      {Key? key, required this.streamName, @required this.builder, this.defaultValue})
      : super(key: key);

  @override
  _StreamListeningSetTypeWidgetState createState() => _StreamListeningSetTypeWidgetState<T>();

}

class _StreamListeningSetTypeWidgetState <T> extends State<StreamListeningSetTypeWidget> {

  T? data;
  var subscriber;

  @override
  void dispose() {
    super.dispose();
    subscriber.cancel();
  }

  @override
  void initState() {
    data = widget.defaultValue;
    subscriber = StreamListeningSetTypeWidget.stream.stream.listen((dynamic action) {
      if(action is StreamObject){
        if (!mounted) {
          subscriber.cancel();
          return;
        }
        if(action.name == widget.streamName){
          setState(() {
              data = action.object;
          });
        }
      }

    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return widget.builder(context,data);
  }
}