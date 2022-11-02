import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

PreferredSizeWidget noramlAppBar(String title) => AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(title,
          style: TextStyle(
              fontSize: 22,
              color: HexColor("#000000"),
              fontWeight: FontWeight.w500)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
    );
