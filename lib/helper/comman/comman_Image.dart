import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../Utill/Comman.dart';


Widget cachedImage(
    String? url, {

      double? height,
      double? width,
      BoxFit? fit,
      Color? color,
      AlignmentGeometry? alignment,
      bool usePlaceholderIfUrlEmpty = true,
    }) {
  if (url == null) {
    return placeHolderWidget(

        height: height, width: width, fit: fit, alignment: alignment);
  }
  else if (url.startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(

            height: height, width: width, fit: fit, alignment: alignment);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return const SizedBox();
        return placeHolderWidget(

            height: height, width: width, fit: fit, alignment: alignment);
      },
    );
  }
  else if (url.endsWith('svg')) {
    return SvgPicture.asset(url,
        height: height,
        width: width,
        color: color,
        fit: fit??BoxFit.fill,
        alignment: alignment ?? Alignment.center);

  }


  else {
    return Image.asset(url,
        height: height,
        width: width,
        color: color,
        fit: fit,
        alignment: alignment ?? Alignment.center);
  }
}