import 'package:animate_do/animate_do.dart';
import 'package:core_project/Features/UploadsImage/presentation/manager/UploadImageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
 import '../../../../Utill/Comman.dart';
import '../../../../helper/color_resources.dart';
import '../../Controllers/ThemeController.dart';
import '../../helper/ImagesConstant.dart';
import '../FetchAllData/presentation/pages/HomeScreen.dart';

class SelectType extends StatefulWidget {
  const SelectType({super.key});

  @override
  State<SelectType> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectType>
    with TickerProviderStateMixin {
  final UploadImageController uploadImageController = Get.put(UploadImageController());

  bool isSelectedAlocation = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isSelectedAlocation == true
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: LoadingAnimationWidget.inkDrop(
                color: Theme.of(context).accentColor,
                size: 40,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: fadeColumn(context),
      ),
    );
  }












  List<String> selectType = ["Upload Image", "Explore Images and data"];

  typeWidget() {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 0, right: 0),
        itemCount: selectType.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(
                milliseconds: index == 0
                    ? 1200
                    : index == 1
                        ? 1600
                        : 2000),
            child: FadeOutUp(
              animate: isSelectedAlocation,
              duration: Duration(
                  milliseconds: index == 0
                      ? 1400
                      : index == 1
                          ? 1600
                          : 1800),
              // delay: Duration(milliseconds: 800),
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    Get.find<UploadImageController>()
                        .imagePick(context: context);
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        isSelectedAlocation = true;
                      });
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        pushRemoveUntil(context: context, route: HomeScreen());
                      });
                    });
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  width: w(context, 1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                          color: Get.find<ThemeController>().darkTheme
                              ? CREAM
                              : LIGHTBLACK
                          //  Theme.of(context).dividerColor
                          )),
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          selectType[index],
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              // color:Provider.of<ThemeController>(context).darkTheme ?

                              // lightAccentText:Grey ,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
  Column fadeColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          child: FadeOutUp(
            animate: isSelectedAlocation,
            duration: const Duration(milliseconds: 1200),
            child: Image.asset(
              ImagesConstants.logo,
              height: 180,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        FadeInUp(
          child: FadeOutUp(
            animate: isSelectedAlocation,
            duration: const Duration(milliseconds: 800),
            child: Text("Select The type of process",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: 18, color: BLACK, fontWeight: FontWeight.w600)),
          ),
        ),
        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: FadeOutUp(
            animate: isSelectedAlocation,
            duration: const Duration(milliseconds: 1000),
            // delay: Duration(milliseconds: 600),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                  "Select The type of process you can change it at any time",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontSize: 14)),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FadeInUp(
          delay: const Duration(milliseconds: 800),
          child: FadeOutUp(
            animate: isSelectedAlocation,
            duration: const Duration(milliseconds: 1200),
            // delay: Duration(milliseconds: 600),
            child: Text("you Can Change This Any Time From Home Screen",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        typeWidget(),
      ],
    );
  }
}
