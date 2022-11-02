import 'package:flutter/material.dart';

import '../../modules/shopping/cart.dart';
import '../appbar/app_bar.dart';
import '../constant.dart';
import '../navigation/navigation.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(name, () {
          navigateTo(context, CartScreen());
        }, appBarIconCart, context),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/undraw_No_data_re_kwbl.png"),
          const Text(
            " No Data Yet",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ])));
  }
}
