import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class BkBtn extends StatelessWidget {
   BkBtn();

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          Navigator.canPop(context)?Navigator.pop(context):(){};
        },
        child: context.locale==  const Locale('ar', 'EG') ?
        RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset('assets/images/arrow.svg',
              color: Colors.black,
              width: 24,
              height: 24,
            )):
        SvgPicture.asset('assets/arrow.svg',
          color:Colors.black,
          width: 24,
          height: 24,
        ),
      );

  }
}