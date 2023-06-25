  import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/color_resources.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/LoginController.dart';


class PhoneAuthWidget extends StatefulWidget {
  @override
  State<PhoneAuthWidget> createState() => _PhoneAuthWidgetState();
}

class _PhoneAuthWidgetState extends State<PhoneAuthWidget> {
  LoginController controller = Get.put(LoginController());
  bool showPasswordAndEmail = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        // showPasswordAndEmail == true

        Form(
                key: _globalKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      textFormField(
                          "Email",
                          emailController,
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.email,
                              size: 20,
                              color: BLACK,
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      textFormField(
                          "password",
                          passwordController,
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.lock,
                                size: 20,
                                color: BLACK,
                              ))),
                    ],
                  ),
                ),
              ),

        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {

              if (!_globalKey.currentState!.validate()) {
                showSnackBarText("please enter Data", context);
                return;
              } else {
                controller.loginWithEmailPassword(
                    emailController, passwordController);
              }


          },
          child: controller.loading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: BLACK,
                  ),
                )
              : Container(
                  height: 60,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "login",
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          fontFamily: "NewFonts", fontSize: 15, color: BLACK),
                    ),
                  ),
                ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  TextFormField textFormField(text, TextEditingController controller, icon) {
    return TextFormField(
        style: const TextStyle(
            color: BLACK, fontWeight: FontWeight.w600, fontSize: 13),
        controller: controller,
        validator: validateObjects(),
        decoration: decoration("$text", context: context),
        onChanged: (val) {
          val = controller.text;
        },
        onSaved: (val) {
          val = controller.text;
        });
  }

  TextFormField textFormField1(text, TextEditingController controller, icon) {
    return TextFormField(
        style: const TextStyle(
            color: BLACK, fontWeight: FontWeight.w600, fontSize: 13),
        controller: controller,
        validator: validateObjects(),
        decoration: decoration("$text", context: context),
        onChanged: (val) {
          val = controller.text;
        },
        onSaved: (val) {
          val = controller.text;
        });
  }



  void showSnackBarText(String text, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
