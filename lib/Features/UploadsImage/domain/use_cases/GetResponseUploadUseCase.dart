import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../Utill/Failure.dart';
import '../repositories/BaseUplodsImagesRepository.dart';

class GetResponseUploadUseCase {
  final BaseUploadsImagesRepository baseBrandRepository;
  GetResponseUploadUseCase(this.baseBrandRepository);
  Future<Either<Failure, String>> call({required File pickerImage}) async {
    return await baseBrandRepository.uploadImageToServer(
        pickerImage: pickerImage);
  }
}
