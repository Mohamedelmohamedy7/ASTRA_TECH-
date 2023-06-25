import 'package:core_project/Utill/size_utils.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:core_project/helper/comman/comman_Image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
 import '../../../../Utill/Comman.dart';
 import '../../Controllers/ThemeController.dart';
 import 'RegisterController.dart';

class RegisterScreen extends StatefulWidget {
  final String email;

  const RegisterScreen({Key? key, required this.email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());

  TextEditingController fNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.email.contains("@")) {
      emailController.text = widget.email;
    }
    super.initState();
  }

  @override
  void dispose() {
    fNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: cachedImage(ImagesConstants.logo,
                    width: size.width * .45,
                    color:
                        Get.find<ThemeController>().darkTheme ? CREAM : null),
              ),
              const SizedBox(
                height: 100,
              ),
              textFormField("First name", fNameController,
                  context: context,
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).accentColor,
                  )),
              const SizedBox(
                height: 16,
              ),
              textFormField("LastName", lNameController,
                  context: context,
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).accentColor,
                  )),
              const SizedBox(
                height: 16,
              ),
              textFormField("phone", phoneNumberController,
                  context: context,
                  icon: Icon(
                    Icons.phone,
                    color: Theme.of(context).accentColor,
                  )),
              const SizedBox(
                height: 16,
              ),
              buildTextFormFieldEmail(context),
              const SizedBox(
                height: 20,
              ),
              textFormField("Password", passwordController,
                  context: context,
                  icon: Icon(
                    Icons.lock,
                    color: Theme.of(context).accentColor,
                  )),
              const SizedBox(
                height: 20,
              ),
              registerButton(context),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldEmail(BuildContext context) {
    return TextFormField(
        style: TextStyle(
            color: Get.find<ThemeController>().darkTheme ? CREAM : LIGHTBLACK,
            fontSize: 14,
            fontFamily: 'NewFonts',
            fontWeight: FontWeight.w500),
        cursorColor: Theme.of(context).accentColor,
        controller: emailController,
        validator: (val) {
          if (val == null || val.isEmpty || val == "") {
            return "";
          } else {
            return null;
          }
        },
        decoration: decoration("Email",
            context: context,
            icon: Icon(
              Icons.mail,
              size: 18,
              color: Theme.of(context).accentColor,
            )),
        onChanged: (val) {
          setState(() {
            val = emailController.text;
          });
        },
        onSaved: (val) {
          setState(() {
            val = emailController.text;
          });
        });
  }

  InkWell registerButton(BuildContext context) {
    return InkWell(
      onTap: register,
      child: GetBuilder<RegisterController>(
        builder: (controller) => controller.loading
            ? LoadingAnimationWidget.flickr(
                size: 40,
                leftDotColor: Theme.of(context).accentColor,
                rightDotColor: Get.find<ThemeController>().darkTheme
                    ? lightAccentText
                    : GREY,
              )
            : Container(
                height: 60,
                width: size.width - 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Center(
                  child: Text(
                    "register",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CREAM,
                        ),
                  ),
                ),
              ),
      ),
    );
  }



  TextFormField textFormField(text, TextEditingController controller,
      {required BuildContext context, icon}) {
    return TextFormField(
        style: TextStyle(
            color: Get.find<ThemeController>().darkTheme ? CREAM : LIGHTBLACK,
            fontSize: 14,
            fontFamily: 'NewFonts',
            fontWeight: FontWeight.w500),
        cursorColor: Theme.of(context).accentColor,
        controller: controller,
        maxLength: "$text" == "phone" ? 11 : 120,
        validator: "$text" == "phone"
            ? (val) {
                if (val!.isEmpty) {
                  return "requiredField";
                } else if (val.length != 11) {
                  return "phoneValidationLength";
                } else if (!val.startsWith('0')) {
                  return "phoneValidationStartsWith";
                }
                return null;
              }
            : validateObjects(),
        decoration: decoration("$text", icon: icon, context: context),
        onChanged: (val) {
          val = controller.text;
        },
        onSaved: (val) {
          val = controller.text;
        });
  }

  void register() {
    if (!_globalKey.currentState!.validate()) {
      custumShowSnackBar(
        context: context,
        imgPath: 'assets/images/warning.png',
        msg: "please enter Data",
        isError: true,
      );
      return;
    }
    FocusScope.of(context).unfocus();
    _globalKey.currentState!.save();
    try {
      if (fNameController.text.isEmpty ||
          phoneNumberController.text.isEmpty ||
          passwordController.text.isEmpty ||
          phoneNumberController.text.isEmpty) {
        custumShowSnackBar(
          context: context,
          imgPath: 'assets/images/warning.png',
          msg: "requiredField",
          isError: true,
        );
      } else {
        Get.find<RegisterController>().register(
          fName: fNameController.text,
          email: emailController.text,
          phone: phoneNumberController.text,
          context: context,
          lName: lNameController.text,
          password: passwordController.text,
        );
      }
    } catch (e) {
      custumShowSnackBar(
        context: context,
        imgPath: 'assets/images/warning.png',
        msg: e.toString(),
        isError: true,
      );
    }
  }
}
