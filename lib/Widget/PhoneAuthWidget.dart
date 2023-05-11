import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:easy_localization/easy_localization.dart';
 import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
 import 'package:provider/provider.dart';

 

class PhoneAuthWidget extends StatefulWidget {
  const PhoneAuthWidget({Key? key}) : super(key: key);

  @override
  State<PhoneAuthWidget> createState() => _PhoneAuthWidgetState();
}

class _PhoneAuthWidgetState extends State<PhoneAuthWidget> {
  bool showPasswordAndEmail = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        showPasswordAndEmail == true
            ? Form(
          key: _globalKey,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                textFormField(
                    "Email".tr(),
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
                    "password".tr(),
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
        )
            : stateRegister(context),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    showPasswordAndEmail
                        ? "enterWithMobile".tr()
                        : "enterWithEmailAndPassword".tr(),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: BLACK,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Icon(
                  showPasswordAndEmail == true
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_sharp,
                  color: BLACK,
                )
              ],
            ),
          ),
          onTap: () {
            if (showPasswordAndEmail) {
              setState(() {
                showPasswordAndEmail = false;
              });
            } else {
              setState(() {
                showPasswordAndEmail = true;
              });
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<LoginProvider>(
          builder: (context, model, _) => GestureDetector(
            onTap: () {
              if (showPasswordAndEmail == true) {
                if (!_globalKey.currentState!.validate()) {
                  showSnackBarText("please enter Data", context);
                  return;
                } else {

                }
              } else {
                if (model.phoneController.text.isEmpty) {
                  showSnackBarText("pleaseAdd".tr(), context);
                } else {
                  model.verifyPhone(
                      model.countryDial + model.phoneController.text, context);
                  // model.getUserStatusMobile(email: model.phoneController.text,context: context)
                  //     .then((value) async {
                  //
                  //   {
                  //     print("${value}--------------*****");
                  //     if (value == true) {
                  //
                  //
                  //     } else {
                  //       showModalBottomSheet(
                  //         isScrollControlled: true,
                  //           backgroundColor: BLACK,
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.vertical(
                  //                   top: Radius.circular(35))),
                  //           context: context,
                  //           builder: (context) =>StatefulBuilder(builder: (context,stat)=> Container(
                  //             height: MediaQuery.of(context).viewInsets.bottom!=0.0?400:150,
                  //             margin: EdgeInsets.all(40),
                  //             child: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 textFormField1("password".tr(), passwordController, Padding(
                  //                   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //                   child: Icon(Icons.lock,
                  //                   color: Colors.white,
                  //                   ),
                  //                 )),
                  //                 SizedBox(height: 10,),
                  //                 InkWell(
                  //                     onTap: (){
                  //                       if(passwordController.text.isNotEmpty) {
                  //                         model.loginWithMobileAndPassword(
                  //                           phone: model.phoneController.text,
                  //                           context: context,
                  //                           password: passwordController.text,
                  //
                  //                         );
                  //                       }
                  //                     },
                  //                     child:Container(
                  //                       padding: EdgeInsets.all(15),
                  //                       width: MediaQuery.of(context).size.width-80,
                  //                       decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.circular(25),
                  //                       ),
                  //                       child: Center(child:  Row(
                  //                         mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                         children: [
                  //
                  //                           Text("login".tr(),style: Theme.of(context).textTheme.headline1?.copyWith(
                  //                               fontSize: 16,fontWeight: FontWeight.w600
                  //                           ),),
                  //
                  //                         ],
                  //                       ),),
                  //                     )),
                  //
                  //               ],
                  //             ),
                  //           )));
                  //     }
                  //   }
                  // });
                }
              }
            },
            child: model.loading == true
                ? const Center(
              child: CircularProgressIndicator(
                color: BLACK,
              ),
            )
                : Container(
              height: 60,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  "login".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontFamily: "NewFonts", fontSize: 15,color: WHITE),
                ),
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
            color: BLACK,
            fontWeight: FontWeight.w600,
            fontSize: 13),
        controller: controller,
        validator: validateObjects(),
        decoration: decoration("$text".tr(),),
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
            color: BLACK,
            fontWeight: FontWeight.w600,
            fontSize: 13),
        controller: controller,
        validator: validateObjects(),
        decoration: decoration("$text".tr()),
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
            controller: Provider.of<LoginProvider>(context, listen: false)
                .phoneController,
            showCountryFlag: true,
            dropdownTextStyle: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
            showDropdownIcon: false,
            flagsButtonMargin: const EdgeInsets.only(left: 10, right: 10),
            initialValue:
            Provider.of<LoginProvider>(context, listen: false).countryDial,
            onCountryChanged: (country) {
              Provider.of<LoginProvider>(context, listen: false).countryDial =
              "+${country.dialCode}";
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
                  color: GREY,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
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
