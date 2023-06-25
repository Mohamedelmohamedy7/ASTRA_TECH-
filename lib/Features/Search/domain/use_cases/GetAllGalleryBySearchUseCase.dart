import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Features/Search/domain/repositories/BaseSearchAndFetchRepository.dart';
import 'package:core_project/Utill/Failure.dart';
import 'package:dartz/dartz.dart';

class GetAllGalleryBySearchUseCase{
  final BaseSearchAndFetchRepository baseSearchAndFetchRepository;
  GetAllGalleryBySearchUseCase(this.baseSearchAndFetchRepository);
  Future<Either<Failure,List<ItemEntity>>> call(String searchText){
    return baseSearchAndFetchRepository.fetchAllImageBySearch(searchText);
  }
}