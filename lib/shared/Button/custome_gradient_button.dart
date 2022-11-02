import 'package:flutter/material.dart';

Widget customGradientButton(Widget firstWidget, Widget secondWidget) =>
    Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/Login3/background.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 007, 165, 91),
                Color.fromARGB(255, 29, 113, 184)
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firstWidget,
            const SizedBox(height: 10),
            secondWidget,
          ],
        ));
