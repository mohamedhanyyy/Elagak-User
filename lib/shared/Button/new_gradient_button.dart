import 'package:flutter/material.dart';

Widget gradientButton(String btnName, VoidCallback function) => MaterialButton(
      onPressed: function,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 24,
        width: 290,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 007, 165, 91),
                Color.fromARGB(255, 29, 113, 184)
              ],
            )),
        padding: const EdgeInsets.all(3.0),
        child: FittedBox(
          child: Text(
            btnName,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
