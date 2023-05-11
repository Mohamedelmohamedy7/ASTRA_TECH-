// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/Route_Manager.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../Model/user_info_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
 
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


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
  /// sign Out With Google
  Future signOutWithGoogle(context) async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut().then((value) {
      logout();
      pushNamedAndRemoveUntil(context: context, route:  Routes.loginRoute);
    });
  } 
  /// sign In With Apple
  Future<void> signOutWithApple(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      logout();
      pushNamedAndRemoveUntil(context:context,route: Routes.loginRoute,);
    } catch (e) {
       talker.error('Error signing out with Apple: $e');
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error signing out with Apple. Please try again.')),
      );
    }
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
        pop(context:context);
        loading = false;
        notifyListeners();
      } catch (e) {
        pop(context:context);

        toast(e.toString());
      }
    } else {
      pop(context:context);
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
              pop(context:context);
              await pushReplacementNamed(context:context, route:Routes.tabBarRoute);
            } else {
              pop(context:context);
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => RegisterScreen(
              //         email: "${phoneController.text}@phone.com")));
            }
          });
        });
      } catch (e) {
        pop(context:context);

        toast("الرقم غير صحيح !!");
      }
    } else {
      pop(context:context);

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
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
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
              pop(context:context);
              await pushReplacementNamed(context:context,route: Routes.tabBarRoute);
            } else {
              pop(context:context);
            }
          });
        } on FirebaseAuthException catch (e) {
          pop(context:context);

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
          pop(context:context);

          toast(
            e.toString(),
          );
        }
      }

      return user;
    } else {
      pop(context:context);

      toast(AppConstants.errorInternetNotAvailable);
    }
    return null;

  }
  /// login With Apple
  Future<User?> loginWithApple({required BuildContext context}) async {
    if (await isNetworkAvailable()) {
      FirebaseAuth auth = FirebaseAuth.instance;

      showLoadingDialog(context, "Please wait...");
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // Set the `clientId` and `redirectUri` to the values obtained during the Apple developer registration
          clientId: 'your_client_id',
          redirectUri: Uri.parse('your_redirect_uri'),
        ),
      );
      try {
        final OAuthProvider oAuthProvider =
        OAuthProvider('apple.com');
        final AuthCredential authCredential = oAuthProvider.credential(
          idToken: credential.identityToken,
          accessToken: credential.authorizationCode,
        );
        User? user;
        if (user != null) {

          getUserStatus(email: credential.email!).then((value) async {
            if (state == true) {
              final UserCredential userCredential = await auth.signInWithCredential(authCredential);
              user = userCredential.user;
              saveUserData(value);
              notifyListeners();
              pop(context:context);
              await pushReplacementNamed(context:context,route: Routes.tabBarRoute);
            } else {
              pop(context:context);
            }
          });
        }
        return user;
      } on FirebaseAuthException catch (e) {
        pop(context:context);
        if (e.code == 'account-exists-with-different-credential') {
          toast(
            "account-exists-with-different-credential",
          );
        } else if (e.code == 'invalid-credential') {
          toast(
            "invalid-credential",
          );
        }
      } catch (e) {
        pop(context:context);
        toast(
          e.toString(),
        );
      }
    } else {
      pop(context:context);
      toast(AppConstants.errorInternetNotAvailable);
    }
    return null;
  }
  /// login with facebook
  Future<User?> loginWithFacebook({required BuildContext context}) async {
    if (await isNetworkAvailable()) {

      showLoadingDialog(context, "Please wait...");
      try {
        final LoginResult result = await FacebookAuth.instance.login();
        User? user;
        if (result.status == LoginStatus.success) {
           final AccessToken accessToken = result.accessToken!;
          final AuthCredential authCredential = FacebookAuthProvider.credential(accessToken.token);

          await FirebaseAuth.instance.signInWithCredential(authCredential).then((credential) {
            user = credential.user;
            if (user != null) {
              getUserStatus(email: user!.email!).then((value) async {
                if (state == true) {
                  final UserCredential userCredential = await value.signInWithCredential(authCredential);
                  user = userCredential.user;
                  saveUserData(value);
                  notifyListeners();
                  pop(context:context);
                  await pushReplacementNamed(context:context,route: Routes.tabBarRoute);
                } else {
                  pop(context:context);
                }
              });
            }
          });

          return user;
        } else if (result.status == LoginStatus.cancelled) {
          pop(context:context);
          toast("Login cancelled by user");
        } else {
          pop(context:context);
          toast("Error logging in with Facebook");
        }
      } on FirebaseAuthException catch (e) {
        pop(context:context);
        if (e.code == 'account-exists-with-different-credential') {
          toast(
            "account-exists-with-different-credential",
          );
        } else if (e.code == 'invalid-credential') {
          toast(
            "invalid-credential",
          );
        }
      } catch (e) {
        pop(context:context);
        toast(
          e.toString(),
        );
      }
    } else {
      pop(context:context);
      toast(AppConstants.errorInternetNotAvailable);
    }
    return null;
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
