import 'package:flutter/material.dart';

import '../Button/new_gradient_button.dart';
import '../loading/image_wifget.dart';

Widget productItem(
        String productName,
        BuildContext context,
        String productPrice,
        String imageSrc,
        String btnName,
        VoidCallback function) =>
    Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Expanded(
              child: defaultNetworkImg(
                  context, 70, double.infinity, imageSrc, BoxFit.cover, 0, 5)),
          const SizedBox(height: 5),
          Text(productName,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          const SizedBox(height: 4),
          Text(productPrice,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          const SizedBox(height: 5),
          gradientButton(btnName, function),
        ],
      ),
    );
