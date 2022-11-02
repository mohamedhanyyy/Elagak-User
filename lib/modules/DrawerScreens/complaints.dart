import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button_class.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/constant.dart';

var titleController = TextEditingController();
var bodyController = TextEditingController();
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();

class ComplaintsScreen extends StatelessWidget {
  ComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: fixxedAppBar("مقترحات و شكاوى"),
              body: Stack(
                children: [
                  backgroundImage(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: cubit.loginModel == null
                            ? Column(
                                children: [
                                  myTextFormField(
                                    context: context,
                                    controller: nameController,
                                    inputType: TextInputType.name,
                                    label: Text("الاسم",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#A5A5A5"))),
                                  ),
                                  const SizedBox(height: 35),
                                  myTextFormField(
                                    context: context,
                                    controller: emailController,
                                    inputType: TextInputType.emailAddress,
                                    label: Text("البريد الإلكتروني",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#A5A5A5"))),
                                  ),
                                  const SizedBox(height: 35),
                                  myTextFormField(
                                    context: context,
                                    controller: phoneController,
                                    inputType: TextInputType.phone,
                                    label: Text("رقم الهاتف",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#A5A5A5"))),
                                  ),
                                  const SizedBox(height: 35),
                                  myTextFormField(
                                      context: context,
                                      controller: titleController,
                                      label: const Text("عنوان الشكوى")),
                                  const SizedBox(height: 20),
                                  myTextFormField(
                                    context: context,
                                    controller: bodyController,
                                    inputType: TextInputType.multiline,
                                    lines: 5,
                                    label: Text("تفاصيل الشكوى",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#A5A5A5"))),
                                  ),
                                  const SizedBox(height: 35),
                                  myButtonClass(
                                      title: "ارسال الطلب",
                                      color: "#1D71B8",
                                      pressAction: () {
                                        cubit
                                            .contactUS(
                                                email: emailController.text,
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                body: bodyController.text,
                                                title: titleController.text,
                                                context: context)
                                            .then((value) {
                                          print(
                                              "emailController is : ${emailController.text} \n nameController is : ${nameController.text} \n phoneController is : ${phoneController.text} \n bodyController is : ${bodyController.text} \n titleControlleris : ${titleController.text} ");
                                        });
                                      })
                                ],
                              )
                            : Column(
                                children: [
                                  const SizedBox(height: 35),
                                  myTextFormField(
                                      context: context,
                                      controller: titleController,
                                      label: const Text("عنوان الشكوى")),
                                  const SizedBox(height: 20),
                                  myTextFormField(
                                    context: context,
                                    controller: bodyController,
                                    inputType: TextInputType.multiline,
                                    lines: 5,
                                    label: Text("تفاصيل الشكوى",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: HexColor("#A5A5A5"))),
                                  ),
                                  const SizedBox(height: 35),
                                  myButtonClass(
                                      title: "ارسال الطلب",
                                      color: "#1D71B8",
                                      pressAction: () {
                                        cubit
                                            .contactUS(
                                                email: cubit
                                                    .loginModel!.data!.email
                                                    .toString(),
                                                name: cubit
                                                    .loginModel!.data!.name
                                                    .toString(),
                                                phone: cubit
                                                    .loginModel!.data!.phone
                                                    .toString(),
                                                body: bodyController.text,
                                                title: titleController.text,
                                                context: context)
                                            .then((value) {
                                          print(
                                              "emailController is : ${emailController.text} \n nameController is : ${nameController.text} \n phoneController is : ${phoneController.text} \n bodyController is : ${bodyController.text} \n titleControlleris : ${titleController.text} ");
                                        });
                                      })
                                ],
                              )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
