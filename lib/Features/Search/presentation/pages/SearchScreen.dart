import 'package:core_project/Features/Search/presentation/manager/GetAllDataBySearchController.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/comman/comman_Image.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../helper/ImagesConstant.dart';
import '../../../FetchAllData/presentation/widgets/ItemWidget.dart';
import '../../../IntroducePart/select_Type.dart';

class SearchScreen extends StatefulWidget {

  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GetAllDataBySearchController controller =
      Get.put(GetAllDataBySearchController());

  final FocusNode searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      MediaQuery.of(context).viewInsets.bottom != 0
              ? const SizedBox()
              : FloatingActionButton(
                  onPressed: () {
                    pop(context: context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:  GestureDetector(
          onTap: () {
    push(context: context, route: SelectType());
    },
    child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 16),
              ),
              const Icon(
                Icons.arrow_drop_down_outlined,
                color:BLACK,
              )
            ],
    )),
        ),
        leadingWidth: 220,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: cachedImage(ImagesConstants.logo, width: 70, height: 80),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? _buildLoadingIndicator()
            : _buildContent(context),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(context) {
    return Obx(
          () => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: controller.searchController,
              onFieldSubmitted: (_) => controller.fetchDataBySearch(),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  IconlyBroken.search,
                  color: BLACK,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.delete();
                    // Update the state after clearing the search controller and documents
                    controller.update();
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    color: BLACK,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .primaryColor, // Border color when focused
                    width: 2.0, // Border width when focused
                  ),
                ),
                labelText: 'Search',
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          Expanded(
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(10),
              itemCount: controller.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemWidget(
                  index: index,
                  itemsEntities:controller.documents ,
                  itemEntity: controller.documents[index],
                );
              },
              staggeredTileBuilder: (int index) {
                return StaggeredTile.count(2, index.isEven ? 3.5 : 1.8);
              },
              mainAxisSpacing: 8,
              crossAxisSpacing: 8, // Spacing between columns
            ),
          ),
        ],
      ),
    );
  }


}
