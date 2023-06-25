 import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:lottie/lottie.dart';
import '../FetchAllData/presentation/widgets/ImageDisplay.dart';
import '../UploadsImage/presentation/manager/UploadImageController.dart';


class SuccessScreen extends StatelessWidget {
  final UploadImageController uploadImageController = Get.put(UploadImageController());

  final String fileId;

  SuccessScreen({super.key, required this.fileId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Lottie.asset("assets/images/9917-success.json",
                width: 200, height: 200, fit: BoxFit.cover, repeat: false),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Image is sent successfully",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: BLACK,
                    fontSize: 16,
                  ),
            ),
            const Spacer(),
            mainTabs(context),
          ],
        ),
      ),
    );
  }

  GestureDetector mainTabs(BuildContext context) {
    return GestureDetector(
      onTap: () {
        uploadImageController.fetchData(fileId).then((value) {
          push(
              context: context,
              route: ImageDisplay(
                map: value,
              ));
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).accentColor),
        child: Text(
          "Explore Image",
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: WHITE,
                fontSize: 14,
              ),
        ),
      ),
    );
  }
}
