import 'package:core_project/Features/Login/LoginController.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class MediaAuthWidget extends StatelessWidget {
LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => controller
              .loginWithGoogle( context),
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color:Theme.of(context).primaryColor)
              // color: const Color(0xFFEA4336),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(
                  FontAwesomeIcons.apple,
                  color: BLACK,
                  size: 23.0,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: InkWell(
            onTap: () {

              controller.loginWithGoogle( context).then((value){
                Navigator.pop(context);
              });

            },
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border:
                  Border.all(color:Theme.of(context).primaryColor)
                // color: const Color(0xFFEA4336),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.google,
                    color: BLACK,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
