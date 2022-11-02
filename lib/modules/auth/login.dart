import 'package:elagy_user_app/modules/auth/register.dart';
import 'package:elagy_user_app/modules/auth/reset_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/constant.dart';
import '../../shared/navigation/navigation.dart';

class LoginScreenUser extends StatelessWidget {
  LoginScreenUser({Key? key}) : super(key: key);
  var size, height, width;
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
              child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                backgroundImage(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Stack(children: [
                        backgroundImage(width, height),
                        Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            logo,
                            const SizedBox(height: 26),
                            const Text("تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 16),
                            Text("برجاء قم بتسجيل الدخول او بإنشاء حساب",
                                style: TextStyle(
                                    fontSize: 18, color: HexColor("#A5A5A5"))),
                            const SizedBox(height: 51),
                            myTextFormField(
                              controller: phoneController,
                              context: context,
                              inputType: TextInputType.emailAddress,
                              hint: "John@Doe.com",
                              label: Text("البريد الإلكتروني",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 26),
                            myTextFormField(
                              controller: passwordController,
                              context: context,
                              inputType: TextInputType.visiblePassword,
                              obsecure: true,
                              lines: 1,
                              hint: "****************",
                              label: Text("كلمة المرور",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    navigateTo(context, ResetPassword());
                                  },
                                  child: Text(
                                    "نسيت كلمة المرور",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: HexColor("#E2C520")),
                                  )),
                            ),
                            const SizedBox(height: 10),
                            cubit.isLoadingAuth
                                ? CircularProgressIndicator(
                                    color: HexColor("#04914F"))
                                : myButton("تسجيل الدخول", "#3193E5", () {
                                    cubit.loadingAuthScreens(true);
                                    cubit.login(
                                        password: passwordController.text,
                                        email: phoneController.text,
                                        context: context);
                                  }),
                            const SizedBox(height: 10),
                            Center(
                                child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'ليس لديك أي حساب؟ ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                TextSpan(
                                    text: 'إنشاء حساب',
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
                        ))
                      ])),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
