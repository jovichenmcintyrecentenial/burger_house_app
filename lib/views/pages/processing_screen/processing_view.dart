import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:flutter/material.dart';

class ProcessingView extends StatelessWidget {

  static var routeName = "ProcessingView";
  final GenericArgs<SegueModel>? args;

  const ProcessingView({
    super.key, this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}