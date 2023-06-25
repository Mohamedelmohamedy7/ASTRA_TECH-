import 'package:core_project/Features/Login/LoginController.dart';
 import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

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
            // : stateRegister(context),

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

  Widget stateRegister(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          IntlPhoneField(
            initialCountryCode: 'EG',
            controller: controller.phoneController,
            showCountryFlag: true,
            dropdownTextStyle: const TextStyle(
                color:BLACK, fontSize: 15, fontWeight: FontWeight.w500),
            showDropdownIcon: false,
            flagsButtonMargin: const EdgeInsets.only(left: 10, right: 10),
            initialValue: controller.countryDial,
            onCountryChanged: (country) {
              controller.countryDial = "+${country.dialCode}";
            },
            decoration: InputDecoration(
              counter: const SizedBox.shrink(),
              // counterStyle: const TextStyle(
              //     height: double.minPositive,
              //     fontWeight: FontWeight.w500,
              //     fontSize: 14),
              errorStyle:
                  const TextStyle(fontSize: 12.0, fontFamily: "headline1"),
              hintText: "10000000000",
              hintStyle: const TextStyle(
                  color: GREY, fontSize: 16, fontWeight: FontWeight.w500),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: GREY),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: GREY),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: GREY),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: GREY)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: GREY)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBarText(String text, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
