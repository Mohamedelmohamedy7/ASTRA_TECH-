import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';

class ItemModel extends ItemEntity {
  ItemModel(
      {required super.id,
      required super.imageName,
      required super.url,
      required super.createdAt});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        id: json["id"],
        imageName: json["imageName"],
        url: json["image"]??"",
        createdAt: json["createdAt"].toString());
  }
}
