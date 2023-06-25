import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/Features/IntroducePart/select_Type.dart';
import 'package:core_project/Features/Register/RegisterScreen.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/Route_Manager.dart';
import 'package:core_project/helper/app_constants.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

import '../Model/user_info_model.dart';


class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;
  String otpPin = " ";
  String countryDial = "+20";
  String verID = " ";
  int screenState = 0;
  Color blue = const Color(0xff8cccff);
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool state = false;
  bool loading = false;

  /// sign Out With Google
  Future<void> signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut().then((value) {
      logout();
      Get.offAllNamed(Routes.loginRoute);
    });
  }

  /// sign In With Apple
  Future<void> signOutWithApple() async {
    try {
      await FirebaseAuth.instance.signOut();
      logout();
      Get.offAllNamed(Routes.loginRoute);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error signing out with Apple. Please try again.',
      );
    }
  }


  /// loginWithGoogle
  Future<User?> loginWithGoogle(context) async {
    if (await isNetworkAvailable()) {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          getUserStatus(email: googleSignIn.currentUser!.email)
              .then((value) async {
            if (value != null) {
              final UserCredential userCredential =
                  await auth.signInWithCredential(credential);
              user = userCredential.user;
              globalAccountData.setLoginInState(true);
              saveUserData(data: Users.fromJson(value));
              phoneController.clear();
              Get.back();
              await Get.to(() => SelectType());
            } else {
              Get.back();
              Get.to(() => RegisterScreen(
                    email: googleSignIn.currentUser!.email,
                  ));
            }
          });
        } on FirebaseAuthException catch (e) {
          Get.back();
          if (e.code == 'account-exists-with-different-credential') {
            Get.snackbar(
              'Error',
              'An account with a different credential already exists.',
            );
          } else if (e.code == 'invalid-credential') {
            Get.snackbar(
              'Error',
              'Invalid credential.',
            );
          }
        } catch (e) {
          Get.back();
          Get.snackbar(
            'Error',
            e.toString(),
          );
        }
      }
      return user;
    } else {
      Get.back();
      Get.snackbar(
        'No Internet',
        'Internet is not available.',
      );
    }
    return null;
  }

  ///  getUserStatus
  Future getUserStatus({required String email}) async {
    if (await isNetworkAvailable()) {
      try {
        var snapshot = await FirebaseFirestore.instance
            .collection('UsersCollection')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();
        return snapshot.size > 0 ? snapshot.docs[0].data() : null;
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
        );
      }
    } else {
      Get.snackbar(
        'No Internet',
        AppConstants.errorInternetNotAvailable,
      );
    }
  }

  Future<void> loginWithEmailPassword(
      emailController, passwordController) async {
    if (await isNetworkAvailable()) {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        if (user != null) {
          getUserStatus(email: user.email!).then((value) async {
            if (value != null) {
              globalAccountData.setLoginInState(true);
              saveUserData(data: Users.fromJson(value));
              phoneController.clear();
              Get.back();
              await Get.to(() => const SelectType());
            } else {
              Get.back();
              Get.to(() => RegisterScreen(
                    email: googleSignIn.currentUser!.email,
                  ));
            }
          });
        } else {}
      } on FirebaseAuthException catch (e) {
        Get.back();
        if (e.code == 'user-not-found') {
          Get.snackbar(
            'Error',
            'User not found.',
          );
          Get.to(() => RegisterScreen(email: emailController.text));
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
            'Error',
            'Wrong password.',
          );
        }
      } catch (e) {
        Get.back();
        Get.snackbar(
          'Error',
          e.toString(),
        );
      }
    } else {
      Get.back();
      Get.snackbar(
        'No Internet',
        'Internet is not available.',
      );
    }
  }

  Future<void> logout() async {
    await globalAccountData.setId('');
    await globalAccountData.setPhoneNumber('');
    await globalAccountData.setEmail('');
    await globalAccountData.setUsername('');
    await globalAccountData.setLoginInState(false);
    update();
  }
}
