import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/helper/app_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../../../../Utill/Comman.dart';
import '../../../../Utill/Local_User_Data.dart';
import '../../../../helper/ErrorModel.dart';
import 'package:path/path.dart' as path;

abstract class BaseUploadImageToServerRemoteData {
  Future<String> uploadImageRemoteData({required File  pickerImage});
}

class UploadImageToServerRemoteData extends BaseUploadImageToServerRemoteData {
  @override
  Future<String> uploadImageRemoteData({required File pickerImage}) async {
    try {
      String fileName = const Uuid().v1();
      int status = 1;
      collectionProcess(AppConstants.ImagesDataCollection).doc(fileName).set({"createdAt": Timestamp.now(),
        "image": "", "id":fileName, "userId":globalAccountData.getId(),
        "typeMessage": "image",
      });
      String imageName = path.basename(pickerImage.path);
      var ref = FirebaseStorage.instance.ref().child("images").child(imageName.replaceAll("scaled_", "").trim());
      var uploadTask = await ref.putFile(pickerImage).catchError((e) async {
        await collectionProcess(AppConstants.ImagesDataCollection).doc(fileName).delete();
        status = 0;
      });
      if (status == 1) {
        String imageUrl = await uploadTask.ref.getDownloadURL();
        collectionProcess(AppConstants.ImagesDataCollection).doc(fileName).update({"image": imageUrl,"imageName":imageName.replaceAll("scaled_", "").trim()});
        return fileName;
      } else {
        return "";
      }
    } catch (e) {
      talker.error("uploadImageRemoteData = : -> $e");
      errorResponse(e);
     }

  }
}

Never errorResponse(Object e) {
  return throw ServerException(
      errorModel: ErrorModel.fromJson({
        {"message": e.toString()},
        {"statusCode", 403}
      } as Map<String, dynamic>));
}