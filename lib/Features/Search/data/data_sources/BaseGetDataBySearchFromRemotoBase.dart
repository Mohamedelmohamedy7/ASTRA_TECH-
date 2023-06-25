import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_project/Utill/Comman.dart';

import '../../../FetchAllData/data/models/ItemModel.dart';
import '../../../../helper/app_constants.dart';
abstract class BaseGetDataBySearchFromRemotoBase {
  Future< List<ItemModel>> getAllFetchDataBySearch(String searchText);
}
class GetDataBySearchFromRemoteBase extends  BaseGetDataBySearchFromRemotoBase{
  @override
  Future< List<ItemModel>> getAllFetchDataBySearch(String searchText) async {
    print(searchText);
    List<QueryDocumentSnapshot> allDocuments = [];
    final QuerySnapshot snapshot = await collectionProcess(AppConstants.ImagesDataCollection)
        .where('imageName', isGreaterThanOrEqualTo: searchText)
        .where('imageName', isLessThan: '${searchText}z')
        .get();
     final List<QueryDocumentSnapshot> documents = snapshot.docs;
    for (final doc in documents) {
      QueryDocumentSnapshot data = doc;
      allDocuments.add(data);
     }
    return List<ItemModel>.from(allDocuments.map((e) =>
        ItemModel.fromJson(e.data() as Map<String, dynamic>))).toList();
  }
}