import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Features/FetchAllData/domain/repositories/BaseFetchAllDataRepository.dart';
import 'package:core_project/Utill/Failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../helper/ErrorModel.dart';
import '../data_sources/BaseGetDataFromRemotoBase.dart';

class FetchALlDataRepository extends BaseFetchAllDataRepository{
  final BaseGetDataFromRemoteBase baseGetDataFromRemoteBase;
  FetchALlDataRepository(this.baseGetDataFromRemoteBase);
  @override
  Future<Either<Failure, List<ItemEntity>>> fetchAllImage( ) async{
    try {
      final result = await baseGetDataFromRemoteBase.getAllFetchData();

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorModel.message));
    }
  }

}



