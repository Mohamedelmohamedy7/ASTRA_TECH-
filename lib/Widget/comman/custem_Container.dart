import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../helper/text_style.dart';
class CustemContainer extends StatelessWidget {
  final BuildContext context;
  final String text;
  final double margin;
  final double height;
  final int decrease;

  const CustemContainer(
      {super.key,
      required this.context,
      required this.text,
      required this.margin,
      required this.height,
      required this.decrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: margin),
      width: MediaQuery.of(context).size.width - decrease ?? 0,
      height: height,
      child: Center(
        child: Text(
          text.tr(),
          style: CustomTextStyle.medium14Black,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
