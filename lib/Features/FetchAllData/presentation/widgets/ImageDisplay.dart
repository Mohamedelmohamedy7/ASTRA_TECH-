import 'package:core_project/Features/FetchAllData/presentation/pages/HomeScreen.dart';
import 'package:core_project/Utill/Comman.dart';
 import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';

import '../../../../Utill/size_utils.dart';
import 'package:core_project/helper/comman/comman_Image.dart';

class ImageDisplay extends StatelessWidget {
  Map<String, dynamic> map;

  ImageDisplay({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: cachedImage(map["image"],
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.fitHeight)),
            imageStyle(context),
          ],
        ),
      ),
    );
  }

  Container imageStyle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(bottom: 40, left: 10, right: 15),
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
            BLACK,
            BLACK.withOpacity(.2),
            WHITE.withOpacity(0),
          ])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  map["imageName"],
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 14, color: WHITE),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              pushRemoveUntil(context: context, route: HomeScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).accentColor),
              child: Text(
                "Main Screen",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: WHITE, fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
