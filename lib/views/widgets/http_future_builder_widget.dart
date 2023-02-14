// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';


import '../../data/http/http_client.dart';

class HttpBuilderWidget<T> extends StatefulWidget {
  final Future<T>? initialData;
  final dynamic future;
  final onSuccess;
  final onError;
  final builder;
  final bool pullToRefresh;

  const HttpBuilderWidget({
    Key? key,
    this.initialData,
    this.future,
    this.onSuccess,
    this.onError,
    @required this.builder,
    this.pullToRefresh = false,
  }) : super(key: key);

  @override
  _HttpBuilderWidgetState createState() => _HttpBuilderWidgetState<T>();
}

class _HttpBuilderWidgetState<T> extends State<HttpBuilderWidget> {
  T? data;

  StreamController<T> steamController = StreamController<T>();

  @override
  void initState() {
    // TODO: implement initState
    _executeHttpRequest();
    super.initState();
  }

  @override
  void dispose() {
    steamController.close();
    super.dispose();
  }

  void _executeHttpRequest() {

    HttpCustomClient.getData<T>(
        initialData: widget.pullToRefresh == false ? widget.initialData: null,
        future: widget.future != null && widget.future is Function? widget.future() : widget.future,
        onSuccess: (T value) {

          if(value != null) {
            if (widget.onSuccess != null) {
              widget.onSuccess(value);
            }
            steamController.add(value);
            data = value;
          }
        },
        onError: (value) {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pullToRefresh) {
      _executeHttpRequest();
    }
    return StreamBuilder<T>(
        stream: steamController.stream,
        builder: (context, snapshot) {
          return widget.builder(context, data);
        }); //widget.builder(context, this.data);
  }
}
