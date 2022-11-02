import 'package:elagy_user_app/shared/appbar/normal_app_bar.dart';
import 'package:elagy_user_app/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button.dart';
import '../../shared/TextForm/text_form_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordControllr = TextEditingController();
    var nameController = TextEditingController();
    var emailControllr = TextEditingController();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: HexColor("#FBFBFB"),
              appBar: noramlAppBar("البروفايل"),
              body: Stack(
                children: [
                  backgroundImage(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 122,
                          height: 122,
                          child: InkWell(
                            onTap: () => cubit.pickProfileImage(),
                            child: Stack(
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.greenAccent[100],
                                    radius: 60,
                                    backgroundImage: NetworkImage(cubit
                                            .myProfileModel!.data!.photo ??
                                        "https://th.bing.com/th/id/OIP.eXWcaYbEtO2uuexHM8sAwwHaHa?pid=ImgDet&w=4000&h=4000&rs=1"),
                                  ), //CircleAvatar
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: HexColor('#04914F')),
                                        child: const Icon(Icons.camera,
                                            size: 35, color: Colors.white)))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        myTextFormField(
                            context: context,
                            label: Text(
                              "رقم الهاتف",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("#A5A5A5")),
                            ),
                            controller: phoneController,
                            lines: 1,
                            hint: "+201xxxxxxxxx",
                            inputType: TextInputType.phone),
                        const SizedBox(height: 15),
                        myTextFormField(
                            context: context,
                            label: Text(
                              "الاسم بالكامل",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("#A5A5A5")),
                            ),
                            controller: nameController,
                            lines: 1,
                            hint: "John Doe",
                            inputType: TextInputType.name),
                        const SizedBox(height: 15),
                        myTextFormField(
                            context: context,
                            label: Text(
                              "البريد الإلكتروني",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("#A5A5A5")),
                            ),
                            controller: emailControllr,
                            lines: 1,
                            hint: "example@account.com",
                            inputType: TextInputType.emailAddress),
                        const SizedBox(height: 15),
                        myTextFormField(
                            context: context,
                            obsecure: true,
                            label: Text(
                              "كلمة المرور",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("#A5A5A5")),
                            ),
                            controller: passwordControllr,
                            lines: 1,
                            hint: "**************",
                            inputType: TextInputType.visiblePassword),
                        const Spacer(),
                        myButton("حفظ التعديلات", "#1D71B8", () {
                          cubit.updateProfile(
                              email: emailControllr.text,
                              name: nameController.text,
                              phone: phoneController.text,
                              password: passwordControllr.text,
                              profileImagePath: cubit.profileImageePAth,
                              context: context);
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            )));
      },
    );
  }
}
