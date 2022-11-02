import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../loading/image_wifget.dart';

Widget buildPlaceItem(int index, BuildContext context, String image,
    String title, String distance, VoidCallback onTap, double? elevation) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Card(
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: defaultNetworkImg(context, double.infinity,
                      double.infinity, image, BoxFit.contain, 1, 50),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        distance,
                        style:
                            TextStyle(fontSize: 16, color: HexColor("#484848")),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
