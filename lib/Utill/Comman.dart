// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_project/helper/text_style.dart';
 import 'package:easy_localization/easy_localization.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 import '../Model/user_info_model.dart';
 import '../Widget/ProcessingDialog.dart';
import '../helper/ImagesConstant.dart';
import '../helper/color_resources.dart';
import 'Local_User_Data.dart';

///Shared Preference To get User Data From Local
Future<void> saveUserData(UserInfoModel user) async {
  await globalAccountData.setId(user.id.toString());
  await globalAccountData.setUsername(user.fName!+user.lName!);
  await globalAccountData.setEmail(user.email!);
  await globalAccountData.setPhoneNumber(user.phone!);
  // await globalAccountData.setState(user.data!.city.toString());
  // await globalAccountData.setCivilId(user.data!.civilId.toString());
  // await globalAccountData.setAddress(user.data!.address!);
  await globalAccountData.setLoginInState(true);
}

toast(String? value, {ToastGravity? gravity, length = Toast.LENGTH_SHORT, Color? bgColor, Color? textColor, bool print = false,}) {
  Fluttertoast.showToast(
    msg: value!,
    gravity: gravity,
    toastLength: length,
    backgroundColor: bgColor,
    textColor: textColor,
  );
}

/// returns true if network is available
Future<bool> isNetworkAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

/// returns true if connected to mobile
Future<bool> isConnectedToMobile() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.mobile;
}

/// returns true if connected to wifi
Future<bool> isConnectedToWiFi() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult == ConnectivityResult.wifi;
}

/// returns Image(Local,Network)
Widget cachedImage(
  String? url, {
  double? height,
  double? width,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  bool usePlaceholderIfUrlEmpty = true,
}) {
  if (url == null) {
    return placeHolderWidget(
        height: height, width: width, fit: fit, alignment: alignment);
  } else if (url.startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(
            height: height, width: width, fit: fit, alignment: alignment);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return const SizedBox();
        return placeHolderWidget(
            height: height, width: width, fit: fit, alignment: alignment);
      },
    );
  } else {
    return Image.asset(url,
        height: height,
        width: width,
        fit: fit,
        alignment: alignment ?? Alignment.center);
  }
}

Container ButtonContainer(
    {required BuildContext context,
    required String text,
    required double margin,
    required double height,
    double  decrease = 0}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    width: MediaQuery.of(context).size.width - decrease ,
    height: height,
    // decoration: BoxDecoration(
    //     color: ColorResources.getPrimary(context), borderRadius: BorderRadius.circular(15)),
    child: Center(
      child: Text(
        text.tr(),
        style: CustomTextStyle.medium14Black,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

/// returns place Holder Image (asset)

Widget placeHolderWidget(
    {double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment}) {
  return Image.asset(
    ImagesConstants.plashHolder,
    height: height,
    width: width,
    fit: fit ?? BoxFit.contain,
    alignment: alignment ?? Alignment.center,
  );
}

OutlineInputBorder borderStyle = const OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
  ),
  borderSide: BorderSide(
    color: ColorResources.GREY,
  ),
);

validateObjects() {
  return (val) {
    if (val == null || val == "") {
      return "requiredField".tr();
    } else {
      return null;
    }
  };
}

/// Display Text in Style

InputDecoration decoration(text) {
  return InputDecoration(
    hintText: text,
    errorStyle: const TextStyle(
        color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
    hintStyle: CustomTextStyle.medium12White,
    enabledBorder: borderStyle,
    disabledBorder: borderStyle,
    border: borderStyle,
    focusedBorder: borderStyle,
  );
}

bool condition(context) {
  return context.locale == const Locale('en', 'US');
}



showLoadingDialog(context, text) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return ProcessingDialog(
        message: text,
      );
    },
  );
}

