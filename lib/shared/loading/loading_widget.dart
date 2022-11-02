import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget loadingWidget() {
  return Scaffold(
    body: Center(
      child: CircularProgressIndicator(color: HexColor("#04914F")),
    ),
  );
}
