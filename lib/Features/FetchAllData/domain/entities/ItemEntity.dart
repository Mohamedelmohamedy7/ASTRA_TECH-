import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable{
  final String id;
  final String imageName;
  final String url;
   final String createdAt;

  ItemEntity({required this.id,required this.imageName,required this.url,required this.createdAt});

  @override
  // TODO: implement props
  List<Object?> get props => [id,imageName,url,createdAt];
}