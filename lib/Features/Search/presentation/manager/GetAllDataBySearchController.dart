import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utill/Comman.dart';
import '../../../../Utill/RequestState/RequestState.dart';
import '../../../../Utill/Services_locator.dart';
import '../../domain/use_cases/GetAllGalleryBySearchUseCase.dart';

class GetAllDataBySearchController extends GetxController {
  RxList<ItemEntity> documents = <ItemEntity>[].obs;
  RxBool isLoading = false.obs;
  RequestState? state;
  List<ItemEntity> fetchedDocuments = [];
  final TextEditingController searchController = TextEditingController();

  void delete() {
    searchController.clear();
    documents.clear();
    update();
  }
  Future<void> fetchDataBySearch() async {
    isLoading.value = true;
    var result = await GetAllGalleryBySearchUseCase(sl()).call(searchController.text);
    result.fold((l) {
      state = RequestState.failed;
      update();
      return toast(l.message.toString());
    }, (r) {

      state = RequestState.loaded;
      update();
      return documents.value = r;
    });
    isLoading.value = false;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}