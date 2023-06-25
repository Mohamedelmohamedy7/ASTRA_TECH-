import 'dart:io';

import 'package:core_project/Features/UploadsImage/data/data_sources/BaseUploadImageToServerRemoteData.dart';
import 'package:core_project/Features/UploadsImage/domain/repositories/BaseUplodsImagesRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../Utill/Failure.dart';
import '../../../../helper/ErrorModel.dart';

class UplodsImagesRepository extends BaseUploadsImagesRepository {
  final BaseUploadImageToServerRemoteData baseUploadImageToServerRemoteData;

  UplodsImagesRepository({required this.baseUploadImageToServerRemoteData});

  @override
  Future<Either<Failure, String>> uploadImageToServer({required File  pickerImage})async {
    try {
      final result = await baseUploadImageToServerRemoteData.uploadImageRemoteData(pickerImage: pickerImage);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorModel.message));
    }
  }

}
