

import 'package:carousel_slider/carousel_slider.dart';
import 'package:core_project/helper/comman/comman_Image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Utill/Comman.dart';
import '../../Utill/size_utils.dart';
 import '../../helper/color_resources.dart';
import '../FetchAllData/domain/entities/ItemEntity.dart';

class GalleryOpenScreen extends StatefulWidget {
  List<ItemEntity> itemEntities;
  int imgIndex;

  GalleryOpenScreen({super.key, required this.itemEntities, required this.imgIndex});

  @override
  State<GalleryOpenScreen> createState() => _GalleryOpenScreenState();
}

class _GalleryOpenScreenState extends State<GalleryOpenScreen> {
  int? sliderIndex;

  @override
  void initState() {
    sliderIndex = widget.imgIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          carusalSlider(),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: getPadding(start: 16, end: 16, top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSmoothIndicator(
                      activeIndex: sliderIndex!,
                      count: widget.itemEntities.length,
                      axisDirection: Axis.horizontal,
                      effect: WormEffect(
                        spacing: 8.0,
                        radius: 24.0,
                        dotWidth: 22.0,
                        dotHeight: 3.0,
                        type: WormType.normal,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor:  lightAccentText,
                        activeDotColor: Theme.of(context).accentColor,
                      )),
                  SIZEH(15),
                  SizedBox(
                    width: width * .7,
                    child: Text(
                      widget.itemEntities[sliderIndex!].imageName,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 12, height: 1.3,color: WHITE),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  SIZEH(getVerticalSize(50)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox carusalSlider() {
    return SizedBox(
          height: size.height,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: size.height,
              aspectRatio: 1,
              viewportFraction: 1,
              initialPage: widget.imgIndex,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, _) {
                setState(() {
                  sliderIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
            itemCount: widget.itemEntities.length,
            itemBuilder: (context, index, realIndex) {
              return Stack(
                children: [
                  cachedImage(widget.itemEntities[index].url,
                      height: size.height, fit: BoxFit.cover),
                  Container(
                    height: size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                                    BLACK,
                                    WHITE.withOpacity(.2),
                                    WHITE.withOpacity(0),
                                  ])),
                  ),
                ],
              );
            },
          ),
        );
  }
}
