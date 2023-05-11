// ignore_for_file: non_constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_project/helper/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talker/talker.dart';
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



Container ButtonContainer(
    {
    required BuildContext context,
    required String text,
    required double margin,
    required double height,
    double  decrease = 0}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    width: MediaQuery.of(context).size.width - decrease ,
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

final talker = Talker(

  /// Your own observers to handle errors's exception's and log's
  /// like Crashlytics or Sentry observer
  observers: [],
  settings:   TalkerSettings(
    /// You can enable/disable all talker processes with this field
    enabled: true,
    /// You can enable/disable saving logs data in history
    useHistory: true,
    /// Length of history that saving logs data
    maxHistoryItems: 1000,
    /// You can enable/disable console logs
    useConsoleLogs: true,
  ),
  /// Setup your implementation of logger
  logger: TalkerLogger(),
  ///etc...
);
/// returns place Holder Image (asset)

Widget placeHolderWidget({double? height, double? width, BoxFit? fit, AlignmentGeometry? alignment}) {
  return Image.asset(
    ImagesConstants.plashHolder,
    height: height,
    width: width,
    fit: fit ?? BoxFit.contain,
    alignment: alignment ?? Alignment.center,
  );
}

OutlineInputBorder borderStyle =  OutlineInputBorder(
  borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
  ),
  borderSide: BorderSide(
    color:  Grey,
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
/// pushNamedAndRemoveUntil Navigator
pushNamedAndRemoveUntil({required context, required String route})async{
 return await Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
}
/// pushRemoveUntil Navigator
pushRemoveUntil({required context,required Widget route}){
  return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>route), (route) => false);
}
/// push Navigator
push({required context,required Widget route}){
  return Navigator.of(context).push(MaterialPageRoute(builder: (context)=>route));
}
/// pushReplacement Navigator
pushReplacement({required context,required Widget route}){
  return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>route));
}
/// pushReplacementNamed Navigator
pushReplacementNamed({required context,required String route}){
  return Navigator.pushReplacementNamed(context,route);
}
/// pop Navigator
pop({required context}){
  if(Navigator.of(context).canPop()) {
    return Navigator.of(context).pop();
  }else{
    talker.error("❌  No Route found for this material ");
  }
}
