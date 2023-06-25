
import 'package:core_project/Features/FetchAllData/data/data_sources/BaseGetDataFromRemotoBase.dart';
import 'package:core_project/Features/FetchAllData/data/repositories/FetchALlDataRepository.dart';
import 'package:core_project/Features/FetchAllData/domain/repositories/BaseFetchAllDataRepository.dart';
import 'package:core_project/Features/FetchAllData/domain/use_cases/GetAllGalleryUseCase.dart';
import 'package:core_project/Features/Search/data/data_sources/BaseGetDataBySearchFromRemotoBase.dart';
import 'package:core_project/Features/Search/domain/repositories/BaseSearchAndFetchRepository.dart';
import 'package:core_project/Features/UploadsImage/data/repositories/UplodsImagesRepository.dart';
import 'package:core_project/Features/UploadsImage/domain/repositories/BaseUplodsImagesRepository.dart';
import 'package:core_project/Features/UploadsImage/domain/use_cases/GetResponseUploadUseCase.dart';
import 'package:get_it/get_it.dart';

import '../Features/Search/data/repositories/FetchALlDataBySearchRepository.dart';
import '../Features/Search/domain/use_cases/GetAllGalleryBySearchUseCase.dart';
import '../Features/UploadsImage/data/data_sources/BaseUploadImageToServerRemoteData.dart';

final sl = GetIt.instance;
class Services_locator {
  void init() {
    /// REPOSITORY
    sl.registerLazySingleton<BaseUploadsImagesRepository>(() => UplodsImagesRepository(baseUploadImageToServerRemoteData: sl()));
    sl.registerLazySingleton<BaseFetchAllDataRepository>(() => FetchALlDataRepository(sl()));
    sl.registerLazySingleton<BaseSearchAndFetchRepository>(() => FetchALlDataBySearchRepository(sl()));
    ///DATA SOURCE
    sl.registerLazySingleton<BaseUploadImageToServerRemoteData>(() => UploadImageToServerRemoteData());
    sl.registerLazySingleton<BaseGetDataFromRemoteBase>(() => GetDataFromRemoteBase());
    sl.registerLazySingleton<BaseGetDataBySearchFromRemotoBase>(() => GetDataBySearchFromRemoteBase());

    /// USECASE
    sl.registerLazySingleton(() => GetResponseUploadUseCase(sl()));
    sl.registerLazySingleton(() => GetAllGalleryUseCase(sl()));
    sl.registerLazySingleton(() => GetAllGalleryBySearchUseCase(sl()));
  }
}
