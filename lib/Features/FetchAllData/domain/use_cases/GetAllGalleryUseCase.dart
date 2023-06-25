import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Utill/Failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/BaseFetchAllDataRepository.dart';

class GetAllGalleryUseCase{
  final BaseFetchAllDataRepository baseFetchAllDataRepository;
  GetAllGalleryUseCase(this.baseFetchAllDataRepository);
  Future<Either<Failure,List<ItemEntity>>> call( ){
    return baseFetchAllDataRepository.fetchAllImage( );
  }
}