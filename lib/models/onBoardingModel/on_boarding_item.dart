import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OnBoardingItem extends StatelessWidget {
  final String image;
  final String body;
  final String title;

  const OnBoardingItem(
      {Key? key, required this.image, required this.body, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Image(image: AssetImage(image))),
        const SizedBox(height: 30.0),
        Text(
          title,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24.0, color: HexColor("#FFFFFF")),
        ),
        const SizedBox(height: 15.0),
        Text(
          body,
          style: TextStyle(fontSize: 18.0, color: HexColor("#F8F5F5")),
        ),
      ],
    );
  }
}
