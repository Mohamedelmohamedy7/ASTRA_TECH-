import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/app_constants.dart';

import '../models/ItemModel.dart';

abstract class BaseGetDataFromRemoteBase {
  Future< List<ItemModel>> getAllFetchData( );
}
class GetDataFromRemoteBase extends  BaseGetDataFromRemoteBase{
  @override
  Future< List<ItemModel>> getAllFetchData( ) async{

    List<QueryDocumentSnapshot> allDocuments = [];
    QuerySnapshot querySnapshot;
    bool hasMore = true;
    DocumentSnapshot? lastDocument;
    while (hasMore) {
      if (lastDocument == null) {
        querySnapshot = await collectionProcess(AppConstants.ImagesDataCollection).limit(10).get();
      } else {
        querySnapshot = await collectionProcess(AppConstants.ImagesDataCollection).startAfterDocument(lastDocument).limit(10).get();
      }

      final documents = querySnapshot.docs;
      allDocuments.addAll(documents);

      if (documents.length < 10) {
        hasMore = false;
      } else {
        lastDocument = documents.last;
      }
    }
    return List<ItemModel>.from(allDocuments.map((e) => ItemModel.fromJson(e.data() as Map<String,dynamic>))).toList();
  }

}