import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../drawer/meniu_widget.dart';

PreferredSizeWidget fixxedAppBar(String title) => AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(title,
          style: TextStyle(
              fontSize: 18,
              color: HexColor("#000000"),
              fontWeight: FontWeight.w400)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
      leading: const MenuWidget(),
    );
