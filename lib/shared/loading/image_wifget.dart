import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget defaultNetworkImg(BuildContext context, double height, double width,
    String image, BoxFit fit, double padding, double radius) {
  return Container(
    height: height,
    width: width,
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          progressIndicatorBuilder: (context, s, p) => const Padding(
            padding: EdgeInsets.all(18.0),
          ),
          errorWidget: (context, string, dynamic) => Padding(
            padding: EdgeInsets.all(padding),
            child: Image.asset('assets/images/about_us/info(1)@3x.png'),
          ),
          imageUrl: image,
          fit: fit,
        ),
      ),
    ),
  );
}
