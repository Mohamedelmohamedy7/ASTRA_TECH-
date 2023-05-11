

// ignore: must_be_immutable
import 'package:core_project/Widget/MediaAuthWidget.dart';
import 'package:core_project/Widget/PhoneAuthWidget.dart';
import 'package:core_project/Widget/comman/comman_Image.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/Route_Manager.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../helper/color_resources.dart';

class LoginScreen extends StatelessWidget {
  bool isCheckedEng = true;
  bool isCheckedArabic = false;

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, Routes.tabBarRoute);
                }, child:   Text("Skip".tr(),
                  style:CustomTextStyle.extraBold18Gray.copyWith(
                    fontSize: 14
                  ),
                ))
              ],
            ),
            Image.asset(
              ImagesConstants.logo,
              width: 300,
              height:180,
            ),

            Text(
              "${"welcome1".tr()} WE & YOU",
              style: CustomTextStyle.extraBold18Gray.copyWith(
                fontSize:14
              ),
            ),
            const PhoneAuthWidget(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "countineWith".tr(),
              style: CustomTextStyle.extraBold18Gray.copyWith(
                fontSize: 14,color: BLACK
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const MediaAuthWidget(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 260,
              child: Text(
                "terms".tr(),
                style: CustomTextStyle.extraBold18Gray.copyWith(fontSize:12),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}
