import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
 import 'package:core_project/Features/Search/domain/repositories/BaseSearchAndFetchRepository.dart';
import 'package:core_project/Utill/Failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../helper/ErrorModel.dart';
import '../data_sources/BaseGetDataBySearchFromRemotoBase.dart';

class FetchALlDataBySearchRepository extends BaseSearchAndFetchRepository{
  final BaseGetDataBySearchFromRemotoBase baseGetDataBySearchFromRemotoBase;
  FetchALlDataBySearchRepository(this.baseGetDataBySearchFromRemotoBase);
  @override
  Future<Either<Failure, List<ItemEntity>>> fetchAllImageBySearch(String searchText) async{
    try {
      final result = await baseGetDataBySearchFromRemotoBase.getAllFetchDataBySearch(searchText);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(message: failure.errorModel.message));
    }
  }


}



