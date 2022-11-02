import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../modules/auth/login.dart';
import '../Button/button.dart';
import '../appbar/fixxed_appbar.dart';
import '../navigation/navigation.dart';

class MakeLogInMenuScreen extends StatelessWidget {
  MakeLogInMenuScreen({required this.title, Key? key}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: fixxedAppBar(title),
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.asset(
                        'assets/images/newlogo/3elagk WORD.png',
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        'يرجى تسجيل الدخول للوصول لكامل مزايا التطبيق',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 25, color: HexColor('#616363')),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    myButton('تسجيل الدخول الآن', '#0029e7', () {
                      navigateTo(context, LoginScreenUser());
                    })
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
