import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget categories(
        VoidCallback? buttonAction, String categoryName, bool isSelected) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: buttonAction,
        child: Container(
            width: 90,
            height: 35,
            decoration: BoxDecoration(
              border: isSelected ? null : Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
              color: isSelected ? HexColor("#1D71B8") : Colors.white,
            ),
            child: Center(
              child: Text(categoryName,
                  style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.black)),
            )),
      ),
    );
