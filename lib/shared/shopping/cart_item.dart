import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../loading/image_wifget.dart';

Widget cartItems(
  BuildContext context,
  String imageSrc,
  String productName,
  String price,
  String quantity,
  VoidCallback plus,
  VoidCallback minus,
  VoidCallback deletefunction,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        // height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: defaultNetworkImg(context, 70, double.infinity, imageSrc,
                    BoxFit.cover, 0, 0)),
            const Spacer(),
            Column(
              children: [
                Text(productName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 5),
                Text("سعر القطعة $price جنيه ",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    InkWell(
                      onTap: plus,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: HexColor("#FFFFFF"),
                            border: Border.all(color: HexColor("#EBEBEB")),
                          ),
                          child: Image.asset(
                              "assets/images/previous images/+.png"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("الكمية المطلوبة : $quantity",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: minus,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: HexColor("#FFFFFF"),
                            border: Border.all(color: HexColor("#EBEBEB")),
                          ),
                          child: Image.asset(
                              "assets/images/previous images/-.png"),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: deletefunction,
                icon: const Icon(Icons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
