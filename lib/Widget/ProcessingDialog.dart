import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProcessingDialog extends StatelessWidget {
  final String message;

  const ProcessingDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce (
      color: Theme.of(context).primaryColor,
      size: 60.0,
    );
  }
}
