import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Button/new_gradient_button.dart';

Widget offerProductItem(
        String productName,
        String productPriceAfter,
        String productPriceBefore,
        String imageSrc,
        String offer,
        String btnName,
        VoidCallback function) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Stack(children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(imageSrc),
                ),
                Container(
                  width: 50,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: HexColor("#F85656")),
                  child: Text(
                    offer,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ]),
              const SizedBox(height: 5),
              Text(productName,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(productPriceAfter,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  const SizedBox(width: 10),
                  Text(productPriceBefore,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough)),
                ],
              ),
              const SizedBox(height: 5),
              gradientButton(btnName, function),
            ],
          )),
    );
