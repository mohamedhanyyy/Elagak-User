import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget myPreviousOrders(
  String orderNumber,
  String orderDate,
  Function() ontap,
) =>
    InkWell(
      onTap: ontap,
      child: Column(children: [
        Row(
          children: [
            SizedBox(
                width: 40,
                height: 40,
                child: Center(
                    child: Image.asset(
                        "assets/images/previous images/svgexport-6 (12).png"))),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الطلب رقم $orderNumber",
                    style: const TextStyle(fontSize: 16, color: Colors.black)),
                Text(orderDate,
                    style: TextStyle(fontSize: 14, color: HexColor("#979797"))),
              ],
            ),
          ],
        ),
        Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Divider(
              color: HexColor("#707070"),
              height: 15,
            )),
      ]),
    );
