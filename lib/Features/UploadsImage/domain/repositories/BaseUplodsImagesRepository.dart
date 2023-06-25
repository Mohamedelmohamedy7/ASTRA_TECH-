import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../Utill/Failure.dart';

abstract class BaseUploadsImagesRepository {
  Future<Either<Failure, String>> uploadImageToServer({required File  pickerImage});
}
