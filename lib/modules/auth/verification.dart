import 'package:elagy_user_app/cubit/home_cubit.dart';
import 'package:elagy_user_app/cubit/states.dart';
import 'package:elagy_user_app/modules/auth/register.dart';
import 'package:elagy_user_app/shared/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/Button/button.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/navigation/navigation.dart';

class Verificaton extends StatelessWidget {
  Verificaton({Key? key}) : super(key: key);
  var size, height, width;
  var codeverifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return SafeArea(
              child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    backgroundImage(width, height),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            logo,
                            const SizedBox(height: 26),
                            const Text("يرجى تفعيل الحساب الخاص بك",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 16),
                            Text("سوف يتم إرسال كود التفعيل علي البريد المسجل ",
                                style: TextStyle(
                                    fontSize: 18, color: HexColor("#A5A5A5"))),
                            const SizedBox(height: 51),
                            myTextFormField(
                              controller: codeverifyController,
                              context: context,
                              inputType: TextInputType.number,
                              hint: "123456",
                              label: Text("كود التفعيل",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 15),
                            cubit.isLoadingAuth
                                ? CircularProgressIndicator(
                                    color: HexColor("#04914F"))
                                : myButton("إرسال الكود", "#3193E5", () {
                                    cubit.VerifyEmail(
                                        code: codeverifyController.text,
                                        context: context);
                                  }),
                            const SizedBox(height: 10),
                            Center(
                                child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'ليس لديك حساب ؟ ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                TextSpan(
                                    text: "التسجيل",
                                    style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigateTo(context, RegisterScreen());
                                      }),
                              ]),
                            )),
                          ],
                        )))
                  ],
                ),
              ),
            ),
          ));
        });
  }
}
