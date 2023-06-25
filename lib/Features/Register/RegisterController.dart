// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../Model/user_info_model.dart';
// import '../Utill/Comman.dart';
// import '../Utill/Local_User_Data.dart';
// import '../Utill/Notifications/notification.dart';
// import '../helper/Route_Manager.dart';
// import '../helper/app_constants.dart';
//
// class RegisterProvider extends ChangeNotifier {
//   bool loading = false;
//
//   Future register(
//       {required String fName,
//       required String email,
//       required String lName,
//       required String phone,
//       required String password,
//       context}) async {
//     if (await isNetworkAvailable()) {
//       var token = await getToken();
//       showLoadingDialog(context, "text");
//       Map<String, String> data = {
//         "password": password,
//         "first_name": fName,
//         "last_name": lName,
//         "phone": phone,
//         "token": token,
//         "email": email,
//       };
//       bool avalible = await checkValidate(email);
//        if (avalible == true) {
//         final statusState =await pushUserToFirebase(data);
//         notifyListeners();
//         talker.info(statusState.id);
//         if (statusState.id != null) {
//           globalAccountData.setLoginInState(true);
//           Map<String,dynamic> myData = await getUserFromFirebase(statusState.id);
//            saveUserData(data: Users.fromJson(myData));
//           pop(context: context);
//           await Navigator.pushReplacementNamed(context, Routes.tabBarRoute);
//         } else {
//           pop(context: context);
//           return showSnackBar(context,"Ther is some error");
//         }
//       } else {
//         pop(context: context);
//         custumShowSnackBar(
//             context: context,
//             imgPath: 'assets/images/warning.png',
//             msg: "This Email is already Taken" ,
//             isError: true);
//        }
//
//      }
//      custumShowSnackBar(
//         context: context,
//         imgPath: 'assets/images/warning.png',
//         msg: "Internet Is Not Available" ,
//         isError: true);
//   }
//
//   Future<bool> checkValidate(String email) async {
//     return await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .limit(1)
//         .get()
//         .then((value) {
//       return value.docs.isEmpty;
//     });
//   }
//
//   pushUserToFirebase(Map<String, dynamic> data) async {
//     final res = await FirebaseFirestore.instance.collection(AppConstants.UsersCollection).add(data);
//     return res;
//   }
//   getUserFromFirebase(String docId) async {
//     final res = await FirebaseFirestore.instance.collection(AppConstants.UsersCollection).doc(docId).get();
//     return res.data();
//   }
// }

 // ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/Features/IntroducePart/select_Type.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

 import '../../Utill/Comman.dart';
import '../../Utill/Local_User_Data.dart';
import '../../helper/app_constants.dart';
import '../Login/Model/user_info_model.dart';


class RegisterController extends GetxController {
  bool loading = false;

  Future<void> register({
    required String fName,
    required String email,
    required String lName,
    required String phone,
    required String password,
    BuildContext? context,
  }) async {
    if (await isNetworkAvailable()) {
       showLoadingDialog(context, "text");
      Map<String, String> data = {
        "password": password,
        "first_name": fName,
        "last_name": lName,
        "phone": phone,
        "token": "token",
        "email": email,
      };
      bool available = await checkValidate(email);
      if (available == true) {
        final statusState = await pushUserToFirebase(data);
        talker.info(statusState.id);
        if (statusState.id != null) {
          globalAccountData.setLoginInState(true);
          Map<String, dynamic> myData = await getUserFromFirebase(statusState.id);
          saveUserData(data: Users.fromJson(myData));
          pop(context: context);
          await   Get.to(() => SelectType());
        } else {
          pop(context: context);
          return showSnackBar(context, "There is some error");
        }
      } else {
        pop(context: context);
        custumShowSnackBar(
          context: context!,
          imgPath: 'assets/images/warning.png',
          msg: "This Email is already Taken",
          isError: true,
        );
      }
    } else {
      custumShowSnackBar(
        context: context!,
        imgPath: 'assets/images/warning.png',
        msg: "Internet Is Not Available",
        isError: true,
      );
    }
  }

  Future<bool> checkValidate(String email) async {
    final QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    return value.docs.isEmpty;
  }

  Future<DocumentReference<Map<String, dynamic>>> pushUserToFirebase(Map<String, dynamic> data) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: data["email"],
      password:  data["password"],
    );
    return FirebaseFirestore.instance.collection(AppConstants.UsersCollection).add(data);
  }

  Future<Map<String, dynamic>> getUserFromFirebase(String docId) async {
    final DocumentSnapshot<Map<String, dynamic>> res =
    await FirebaseFirestore.instance.collection(AppConstants.UsersCollection).doc(docId).get();
    return res.data()!;
  }
}