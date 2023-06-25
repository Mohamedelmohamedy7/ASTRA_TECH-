import 'package:core_project/Screen/LoginScreen.dart';
import 'package:core_project/Screen/RegisterScreen.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../Features/IntroducePart/select_Type.dart';
import '../Utill/Comman.dart';
import '../helper/ImagesConstant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    /// support Notifications Dialogs
    getNextScreen();
    super.initState();
  }

  getNextScreen() {
     Future.delayed(const Duration(seconds: 5), () {
      return globalAccountData.getLoginInState() == true
          ? push(context: context, route: SelectLocation())
          : push(
              context: context,
              route: LoginScreen(),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Theme.of(context).primaryColor,
              highlightColor: GREY,
              period: const Duration(seconds: 1),
              child: Image.asset(
                ImagesConstants.logo,
                width: 400,
                height: 380,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
