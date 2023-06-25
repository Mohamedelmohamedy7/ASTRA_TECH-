import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Utill/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseFetchAllDataRepository{
  Future<Either<Failure,List<ItemEntity>>> fetchAllImage();
}