// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/Controllers/ThemeController.dart';
import 'package:core_project/Features/UploadsImage/domain/use_cases/GetResponseUploadUseCase.dart';
import 'package:core_project/helper/RequestState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../Utill/Comman.dart';
import '../../../../Utill/Services_locator.dart';
import '../../../../helper/app_constants.dart';
import '../../../../helper/color_resources.dart';
import '../../../Screen/SuccessScreen.dart';
import '../../../Screen/preview_photo.dart';

class UploadImageController extends GetxController {
  File? pickerImage;
  RequestState? state;

  String? fileId = "";

  void imagePick({
    required BuildContext context,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      imageSources(context, picker);
    } catch (e) {
      toast(e.toString());
    }
  }

  void imageSources(BuildContext context, ImagePicker picker) {
    state==RequestState.loading?  LoadingAnimationWidget.flickr(
      size: 40,
      leftDotColor: Theme.of(context).accentColor,
      rightDotColor: Get.find<ThemeController>().darkTheme
          ? lightAccentText
          : GREY,
    ):  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: const BoxDecoration(shape: BoxShape.rectangle),
          child: Wrap(
            children: <Widget>[
              camira(context, picker),
              const Divider(
                height: 6,
                color:BLACK,
              ),
              gallery(context, picker),
            ],
          ),
        );
      },
    );
  }



  Future<void> updateImage(
      value, PickedFile pickedFile, BuildContext context) async {
    if (value != null && value) {
      state = RequestState.loading;
      update();
      pickerImage = File(pickedFile.path);
      var result =
          await GetResponseUploadUseCase(sl()).call(pickerImage: pickerImage!);
      result.fold((l) {
        state = RequestState.failed;
        update();
        return toast(l.message.toString());
      }, (r) {
        state = RequestState.loaded;
        update();
        return fileId = r;
      });
      // Navigator.of(context).pop();
     push(context:context,route: SuccessScreen(fileId:fileId!));
    }
  }
  ListTile gallery(BuildContext context, ImagePicker picker) {
    return ListTile(
      leading: Icon(
        Icons.image,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text('Gallery'),
      onTap: () async {
        try {
          final pickedFile = await picker.getImage(
            source: ImageSource.gallery,
            imageQuality: 80,
            maxWidth: 1280,
            maxHeight: 720,
          );
          if (pickedFile != null) {
            final data = File(pickedFile.path);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewPhoto(
                  willSent: false,
                  provider: FileImage(data),
                  massage: '',
                ),
              ),
            ).then((value) async {
              await updateImage(value, pickedFile, context);
            });
          } else {
            toast(
                "Please try again and make sure the camera is enabled.");
          }
        } catch (ex) {
          toast(
              "Please try again and make sure the camera is enabled.");
        }
      },
    );
  }

  ListTile camira(BuildContext context, ImagePicker picker) {
    return ListTile(
      leading: Icon(
        Icons.camera,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      title: const Text('Camera'),
      onTap: () async {
        try {
          final pickedFile = await picker.getImage(
            source: ImageSource.camera,
            imageQuality: 80,
            maxWidth: 1280,
            maxHeight: 720,
          );

          if (pickedFile != null) {
            final data = File(pickedFile.path);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewPhoto(
                  willSent: false,
                  provider: FileImage(data),
                  massage: '',
                ),
              ),
            ).then((value) async {
              await updateImage(value, pickedFile, context);
            });
          } else {
            toast(
                "Please try again and make sure the camera is enabled.");
          }
        } catch (ex) {
          toast(
              "Please try again and make sure the camera is enabled.");
        }
      },
    );
  }

   fetchData(String documentId) async {
    try {
      DocumentSnapshot<Object?> snapshot = await collectionProcess(AppConstants.ImagesDataCollection).doc(documentId).get();
      return snapshot.data();
    } catch (e) {
      // Handle any errors that occur during data retrieval
      print('Error fetching data: $e');
     return toast('Error fetching data: ${e.toString()}');

    }
  }
}
