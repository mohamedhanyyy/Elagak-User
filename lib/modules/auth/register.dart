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
import 'login.dart';
import 'reset_password.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var size, height, width;
  var phoneController = TextEditingController();
  var passwordControllr = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();

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
              body: Stack(children: [
                backgroundImage(width, height),
                SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            logo,
                            const SizedBox(height: 26),
                            const Text("إنشاء حساب",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 16),
                            Text(
                                "قم بملى جميع حقول بياناتك لاكمال عملية التسجيل",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: HexColor("#A5A5A5"))),
                            const SizedBox(height: 51),
                            myTextFormField(
                              controller: phoneController,
                              context: context,
                              inputType: TextInputType.phone,
                              hint: "+201xxxxxxxxx",
                              label: Text("رقم الهاتف",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 26),
                            myTextFormField(
                              controller: nameController,
                              context: context,
                              inputType: TextInputType.name,
                              hint: "Jon Doe",
                              label: Text("اسم بالكامل",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 26),
                            myTextFormField(
                              controller: emailController,
                              context: context,
                              inputType: TextInputType.emailAddress,
                              hint: "Jon@Doe.com",
                              label: Text("البريد الإلكتروني",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 26),
                            myTextFormField(
                              controller: passwordControllr,
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
                                : myButton("انشاء الحساب", "#3193E5", () async {
                                    await cubit.register(
                                        context,
                                        nameController.text.toString(),
                                        emailController.text.toString(),
                                        passwordControllr.text.toString(),
                                        phoneController.text.toString());
                                  }),
                            const SizedBox(height: 10),
                            Center(
                                child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                  text: 'لديك حساب بالفعل ؟ ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                TextSpan(
                                    text: 'تسجيل الدخول',
                                    style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigateTo(context, LoginScreenUser());
                                      }),
                              ]),
                            )),
                          ],
                        )))),
              ]),
            ),
          ),
        );
      },
    );
  }
}
