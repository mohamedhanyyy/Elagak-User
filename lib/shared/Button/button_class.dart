import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class myButtonClass extends StatelessWidget {
  myButtonClass(
      {required this.pressAction,
      required this.color,
      required this.title,
      Key? key})
      : super(key: key);
  void Function()? pressAction;
  String color;
  String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
  }
}
