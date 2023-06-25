

 import 'package:core_project/Features/Register/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import '../../../Utill/Comman.dart';
   import '../../../helper/ImagesConstant.dart';
import '../../../helper/color_resources.dart';
 import '../controller/LoginController.dart';
import 'MediaAuthWidget.dart';
import 'PhoneAuthWidget.dart';

class LoginScreen extends StatelessWidget {
  final LoginController registerController = Get.put(LoginController());

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
              height: 50,
            ),

            Image.asset(
              ImagesConstants.logo,
              width: 300,
              height:180,
            ),


              PhoneAuthWidget(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "countine With" ,
              style:Theme.of(context).textTheme.headline5?.copyWith(
                fontSize: 14,color: BLACK
              ),
            ),
            const SizedBox(
              height: 18,
            ),
              MediaAuthWidget(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 260,
              child: InkWell(
                onTap: (){
                  push(context: context, route: const RegisterScreen(email: ''));
                },
                child: Text(
                  "Don't Have an account ? Register Now" ,
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontSize:14),
                  textAlign: TextAlign.center,
                ),
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
