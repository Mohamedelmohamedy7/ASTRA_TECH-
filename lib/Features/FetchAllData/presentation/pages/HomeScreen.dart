import 'dart:io';

import 'package:core_project/Features/IntroducePart/select_Type.dart';
import 'package:core_project/Features/Search/presentation/pages/SearchScreen.dart';
import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/helper/ImagesConstant.dart';
import 'package:core_project/helper/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:core_project/helper/comman/comman_Image.dart';
import '../../../Login/controller/LoginController.dart';
import '../../../Login/view/LoginScreen.dart';
import '../manager/GetAllDataController.dart';
import '../widgets/ItemWidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetAllDataController controller = Get.put(GetAllDataController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchData();
    });
    super.initState();
  }

  handleWillPopScopeRoot() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "هل انت متاكد من تسجيل الخروج من التطبيق ؟ ",
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 14, color: Colors.grey.shade500),
            ),
          ],
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "هل انت متاكد من الخروج",
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(fontSize: 15, color: BLACK),
          )
        ]),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  exit(0);
                },
                child: Text(
                  "نعم",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                      color: ColorResources.primaryByOpacity,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "لا",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => handleWillPopScopeRoot(),
        child: Scaffold(
            floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
                ? const SizedBox()
                : GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (LoginController controllerLogin) {
                      return FloatingActionButton(
                        onPressed: () {
                          controllerLogin
                              .logout()
                              .then((value) => Get.offAll(() => LoginScreen()));
                        },
                        child: const Icon(
                          IconlyLight.logout,
                          color: Colors.white,
                        ),
                      );
                    }),
            backgroundColor: WHITE,
            appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        IconlyBroken.search,
                        color: BLACK,
                      ),
                      onTap: () {
                        push(context: context, route: SearchScreen());
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
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
                            color: BLACK,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              leadingWidth: 220,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child:
                      cachedImage(ImagesConstants.logo, width: 70, height: 80),
                )
              ],
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: w(context, 1),
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: controller.editingController,
                        onChanged: (val) {
                          val = controller.editingController.text;
                          controller.filterData();
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            IconlyBroken.search,
                            color: BLACK,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor, // Border color
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
                  ),
                  Obx(
                    () => controller.isLoading.value
                        ? _buildShimmerGrid()
                        : RefreshIndicator(
                            onRefresh: () => controller.fetchData(),
                            // Fetch new data when refreshing
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              itemCount:
                                  controller.editingController.text.isEmpty
                                      ? controller.fetchedDocuments.length
                                      : controller.docsFilter.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ItemWidget(
                                  index: index,
                                  itemsEntities:
                                      controller.editingController.text.isEmpty
                                          ? controller.fetchedDocuments
                                          : controller.docsFilter,
                                  itemEntity:
                                      controller.editingController.text.isEmpty
                                          ? controller.fetchedDocuments[index]
                                          : controller.docsFilter[index],
                                );
                              },
                              staggeredTileBuilder: (int index) {
                                return StaggeredTile.count(
                                    2, index.isEven ? 3.5 : 1.8);
                              },
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8, // Spacing between columns
                            )),
                  ),
                ],
              ),
            )));
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: 10,
      // Number of shimmer items
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        );
      },
    );
  }
}
