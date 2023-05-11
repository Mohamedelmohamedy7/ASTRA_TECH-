 import 'package:core_project/Provider/LoginProvider.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 import 'package:provider/provider.dart';
 

class MediaAuthWidget extends StatelessWidget {
  const MediaAuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          // onTap: () => Provider.of<LoginProvider>(context, listen: false)
          //     .loginWithGoogle(context: context),
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color:BLACK)
              // color: const Color(0xFFEA4336),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

              Provider.of<LoginProvider>(context, listen: false)
                  .loginWithGoogle(context: context).then((value){
                Navigator.pop(context);
              });

            },
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border:
                  Border.all(color:BLACK)
                // color: const Color(0xFFEA4336),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
