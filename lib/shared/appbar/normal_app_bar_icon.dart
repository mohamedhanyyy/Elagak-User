import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../auth/make_login.dart';
import '../navigation/navigation.dart';
import '../network/local/cache_helper.dart';

PreferredSizeWidget normalAppBarIcon(String title, Function()? buttonAction,
        Widget widget, BuildContext context) =>
    AppBar(
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
      actions: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: CacheHelper.getData(key: 'token') == null
                ? () {
                    navigateTo(
                        context,
                        MakeLogInScreen(
                          title: 'الشراء',
                        ));
                  }
                : buttonAction,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    border: Border.all(color: HexColor("#F2F3F8"), width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: widget),
          ),
        ),
      ],
    );
