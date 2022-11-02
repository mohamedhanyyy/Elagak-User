import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget priceSumary(
  int totalPrice,
  int deliveryPrice,
) =>
    Column(
      children: [
        Row(
          children: [
            const Text("السعر ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const Spacer(),
            Text("$totalPrice جنيه",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text("الدليفري",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const Spacer(),
            Text("$deliveryPrice جنيه",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ],
        ),
        const SizedBox(height: 25),
        Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: const Divider(
              color: Colors.black,
              height: 36,
            )),
        Row(
          children: [
            const Text("الإجمالي",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const Spacer(),
            Text("${deliveryPrice + totalPrice} جنيه",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#45DC95"))),
          ],
        )
      ],
    );
