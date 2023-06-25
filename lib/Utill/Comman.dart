// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
   import 'package:core_project/app.dart';
import 'package:core_project/helper/comman/comman_Image.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
 import 'package:talker/talker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Controllers/ThemeController.dart';
  import '../Features/Login/Model/user_info_model.dart';
import '../helper/ImagesConstant.dart';
import '../helper/color_resources.dart';
import '../helper/comman/ProcessingDialog.dart';
import 'Local_User_Data.dart';

///Shared Preference To get User Data From Local
Future<void> saveUserData({
  required Users data,
}) async {
  await globalAccountData.setId(data.id.toString());
  data.fName == null
      ? () {}
      : await globalAccountData.setUsername(
      data.fName! );
  await globalAccountData.setEmail(data.email!);
  data.phone == null
      ? () {}
      : await globalAccountData.setPhoneNumber('${data.phone}');
  await globalAccountData.setLoginInState(true);
}

toast(
    String? value, {
      ToastGravity? gravity,
      length = Toast.LENGTH_SHORT,
      Color? bgColor,
      Color? textColor,
      bool print = false,
    }) {
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



/// Warning , Errors , Success , Log
final talker = Talker(
  /// Your own observers to handle errors's exception's and log's
  /// like Crashlytics or Sentry observer
  observers: [],
  settings: TalkerSettings(
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
Widget placeHolderWidget(
    {
      double? height,
      double? width,
      BoxFit? fit,
      AlignmentGeometry? alignment}) {
  return Image.asset(
    ImagesConstants.logo,
    height: height,
    width: width,
    fit: BoxFit.contain,
    alignment: alignment ?? Alignment.center,
  );
}

UnderlineInputBorder borderStyle = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Theme.of(navigatorKey.currentContext!).dividerColor,
  ),
);

validateObjects() {
  return (val) {
    if (val == null || val == "") {
      return "requiredField" ;
    } else {
      return null;
    }
  };
}

/// Display Decoration in TextFormField

InputDecoration decoration(text, {required context, icon}) {
  return InputDecoration(
    hintText: text,

    hintStyle: TextStyle(
        color:  Get.find<ThemeController>().darkTheme
            ? lightAccentText
            : Grey,
        fontSize: 14,
        fontFamily: 'NewFonts',
        fontWeight: FontWeight.w500),
    counterText: '',
    prefixIcon: icon,
    prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 40),
    errorStyle: const TextStyle(
        fontFamily: 'NewFonts',
        color: LIGHTRED, fontSize: 12, fontWeight: FontWeight.w400),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
    ),
  );
}

CollectionReference collectionProcess(String collectionName){
  return FirebaseFirestore.instance.collection(collectionName);
}
/// show Loading Dialog
showLoadingDialog(context, text, {assignColor}) async {
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

showSnackBar(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

/// pushNamedAndRemoveUntil Navigator
pushNamedAndRemoveUntil({required context, required String route}) async {
  return await Navigator.of(context)
      .pushNamedAndRemoveUntil(route, (route) => false);
}

/// pushRemoveUntil Navigator
pushRemoveUntil({required context, required Widget route}) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => route), (route) => false);
}

/// push Navigator
push({required context, required Widget route}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => route));
}

/// pushNamed Navigator
pushNamed({required context, required String route}) {
  return Navigator.of(context).pushNamed(
    route,
  );
}

/// pushReplacement Navigator
pushReplacement({required context, required Widget route}) {
  return Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => route));
}

/// pushReplacementNamed Navigator
pushReplacementNamed({required context, required String route}) {
  return Navigator.pushReplacementNamed(context, route);
}

/// pop Navigator
pop({required context}) {
  if (Navigator.of(context).canPop()) {
    return Navigator.of(context).pop();
  } else {
    talker.error("❌  No Route found for this material ");
  }
}

w(context, width) {
  return MediaQuery.of(context).size.width * width ?? 1;
}

h(context, height) {
  return MediaQuery.of(context).size.width * height ?? 1;
}

SIZEW(double width) => SizedBox(
  width: width,
);

SIZEH(double height) => SizedBox(
  height: height,
);

custumShowSnackBar({
  required BuildContext context,
  required String imgPath,
  required String msg,
  required bool isError,
}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message: msg,
      textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: CREAM
      ),
      backgroundColor: isError ? RED : Theme.of(context).accentColor,
      icon: cachedImage(
        imgPath,
        color: Colors.white.withOpacity(.5),
      ),
    ),
  );
}
