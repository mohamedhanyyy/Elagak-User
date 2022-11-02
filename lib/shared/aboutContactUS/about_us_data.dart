import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget aboutUSTitle(String imageSrc, String title) => Row(
      children: [
        Image.asset(imageSrc),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
        )
      ],
    );

Widget aboutUsText(String descripation) => Text(
      descripation,
      style: TextStyle(fontSize: 13, color: HexColor("#5F5F5F")),
    );
