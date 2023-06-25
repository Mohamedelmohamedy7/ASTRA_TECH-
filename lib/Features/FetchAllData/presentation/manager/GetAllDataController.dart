import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Features/FetchAllData/domain/use_cases/GetAllGalleryUseCase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utill/Comman.dart';
import '../../../../Utill/RequestState/RequestState.dart';
import '../../../../Utill/Services_locator.dart';
import '../../../../helper/app_constants.dart';
class GetAllDataController extends GetxController {
  RxList<ItemEntity> documents = <ItemEntity>[].obs;
  RxBool isLoading = true.obs;
  RequestState? state;
  List<ItemEntity> fetchedDocuments = [];
   RxList<ItemEntity> docsFilter = <ItemEntity>[].obs;
  TextEditingController editingController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    fetchData( );
  }


  void filterData() {
    docsFilter.clear();
    for (var item in fetchedDocuments) {
      if (item.imageName.contains(editingController.text)) {
        docsFilter.add(item);
      }
    }
  }
  Future<void> fetchData() async {
    isLoading.value = true;
    var result = await GetAllGalleryUseCase(sl()).call( );
    result.fold((l) {
      state = RequestState.failed;
      update();
      return toast(l.message.toString());
    }, (r) {
      state = RequestState.loaded;
      update();
      return fetchedDocuments = r;
    });
    documents.addAll(fetchedDocuments);
    isLoading.value = false;
  }
  void deleteDocument(String documentId,) async {
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.ImagesDataCollection)
          .doc(documentId)
          .delete();

      // Refresh the screen by refetching the data
      await fetchData();
    } catch (e) {
      print('Error deleting document: $e');
      // Handle error if needed
    }
  }
}
