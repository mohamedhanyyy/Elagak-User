import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget myButton(String title, String color, GestureTapCallback pressAction) =>
    SizedBox(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          onPressed: pressAction,
          color: HexColor(color),
          child: Text(title,
              style: const TextStyle(fontSize: 16, color: Colors.white))),
    );
