// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import '../Model/user_info_model.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../Utill/Comman.dart';
import '../Utill/Local_User_Data.dart';
import '../helper/Route_Manager.dart';
import '../helper/app_constants.dart';


class LoginProvider extends ChangeNotifier {


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

  Future signOutWithGoogle(context) async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut().then((value) {
      logout();
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.loginRoute, (Route<dynamic> route) => false);
    });
  }
  /// Send OTP TO PHONE USER
  Future<void> verifyPhone(String number, context) async {
    if (await isNetworkAvailable()) {
      showLoadingDialog(context, "");
      loading = true;
      notifyListeners();
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: number,
          timeout: const Duration(seconds: 20),
          verificationCompleted: (PhoneAuthCredential credential) {
            // showSnackBarText(context,"Auth Completed!");

            notifyListeners();
          },
          verificationFailed: (FirebaseAuthException e) {
            toast(e.toString());
            notifyListeners();
          },
          codeSent: (String verificationId, int? resendToken) {
            // showSnackBarText(context,"OTP Sent!");
            verID = verificationId;
            Navigator.pushNamed(context, Routes.verifyRoute);

            notifyListeners();
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            toast("Timeout!");
            notifyListeners();
          },
        );
        Navigator.pop(context);
        loading = false;
        notifyListeners();
      } catch (e) {
        Navigator.pop(context);

        toast(e.toString());
      }
    } else {
      Navigator.pop(context);

      toast(AppConstants.errorInternetNotAvailable);
    }
  }
  /// Send verify The Number
  Future<void> verifyOTP(context) async {
    showLoadingDialog(context,"من فضلك انتظر");
    if (await isNetworkAvailable()) {

      try {
        await FirebaseAuth.instance
            .signInWithCredential(
          PhoneAuthProvider.credential(
            verificationId: verID,
            smsCode: otpPin,
          ),
        )
            .then((result) {
           getUserStatus(email: "${phoneController.text}@phone.com")
              .then((value) async {
            if (state == true) {
              saveUserData(value);
              notifyListeners();
              Navigator.pop(context);
              await Navigator.pushReplacementNamed(context, Routes.tabBarRoute);
            } else {
              Navigator.pop(context);
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => RegisterScreen(
              //         email: "${phoneController.text}@phone.com")));
            }
          });
        });
      } catch (e) {
        Navigator.pop(context);

        toast("الرقم غير صحيح !!");
      }
    } else {
      Navigator.pop(context);

      toast(AppConstants.errorInternetNotAvailable);
    }
  }
  /// loginWithGoogle
  Future<User?> loginWithGoogle({required BuildContext context}) async {
    if (await isNetworkAvailable()) {
      showLoadingDialog(context,"من فضلك انتظر");
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
            if (state == true) {
              final UserCredential userCredential =
                  await auth.signInWithCredential(credential);
              user = userCredential.user;
              saveUserData(value);
              notifyListeners();
              Navigator.pop(context);
              await Navigator.pushReplacementNamed(context, Routes.tabBarRoute);
            } else {
              Navigator.pop(context);

              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         RegisterScreen(email: googleSignIn.currentUser!.email)));
            }
          });
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context);

          if (e.code == 'account-exists-with-different-credential') {
            toast(
              "account-exists-with-different-credential",
            );
          }
          else if (e.code == 'invalid-credential') {
            toast(
              "invalid-credential",
            );
          }
        } catch (e) {
          Navigator.pop(context);

          toast(
            e.toString(),
          );
        }
      }

      return user;
    } else {
      Navigator.pop(context);

      toast(AppConstants.errorInternetNotAvailable);
    }

  }
  ///  getUserStatus
  Future getUserStatus({required String email}) async {
    if (await isNetworkAvailable()) {
      try {
        final res = await http.post(
            Uri.parse("${AppConstants.BASE_URL}${AppConstants.LOGIN_URI}login"),
            body: {
              "email": email
            },
            headers: {
              HttpHeaders.cacheControlHeader: 'no-cache',
              'Access-Control-Allow-Headers': '*',
              'Access-Control-Allow-Origin': '*',
            });
        final statusState = json.decode(res.body);
        state = statusState["status"];
        notifyListeners();
        return UserInfoModel.fromJson(statusState);
      } catch (e) {
        toast(
          e.toString(),
        );
      }
    } else {
      toast(AppConstants.errorInternetNotAvailable);
    }
  }

  Future<void> logout() async {
    await globalAccountData.setId('');
    await globalAccountData.setCivilId('');
    await globalAccountData.setId('');
    await globalAccountData.setPhoneNumber('');
    await globalAccountData.setEmail('');
    await globalAccountData.setUsername('');
    await globalAccountData.setAddress('');
    await globalAccountData.setCity('');
    await globalAccountData.setState('');
    await globalAccountData.setLoginInState(false);
  }
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
