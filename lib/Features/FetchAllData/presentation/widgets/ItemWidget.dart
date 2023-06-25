import 'package:core_project/Features/FetchAllData/domain/entities/ItemEntity.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/comman/comman_Image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import '../../../../Utill/size_utils.dart';
import '../../../../helper/color_resources.dart';
import '../../../Screen/galery_0pen_B.dart';
import '../manager/GetAllDataController.dart';

class ItemWidget extends StatefulWidget {
  ItemEntity itemEntity;
  int index;
  List<ItemEntity>  ? itemsEntities=[];
  ItemWidget({super.key, required this.itemEntity,required this.index,this.itemsEntities});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final GetAllDataController controller = Get.put(GetAllDataController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        push(context: context, route: GalleryOpenScreen(
          imgIndex:widget.index, itemEntities: widget.itemsEntities! ,

        ));
      },
      child: Stack(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(25),
            child: cachedImage(widget.itemEntity.url,width: size.width,height: size.height,fit: BoxFit.cover)),
          Container(
            height: size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors:  [
                      BLACK.withOpacity(.9),
                      BLACK.withOpacity(.4),
                      BLACK.withOpacity(0),
                    ])),
          ),
          Container(
            height: size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors:  [
                      WHITE,
                      WHITE.withOpacity(.3),
                      WHITE.withOpacity(0.1),
                    ])),
          ),
          GestureDetector(
            onTap: ()=>controller.deleteDocument(widget.itemEntity.id,),
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.dangerous,color: Colors.white,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(widget.itemEntity.imageName,style:
                Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 14
                ),),
            ),
          )
        ],
      ),
    );
  }
}
