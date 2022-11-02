import 'package:elagy_user_app/modules/DrawerScreens/profile.dart';
import 'package:elagy_user_app/shared/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/auth/make_login_menu.dart';
import '../../shared/auth/profile_widget.dart';
import '../../shared/constant.dart';
import '../../shared/network/local/cache_helper.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                  child: CacheHelper.getData(key: 'token') == null
                      ? MakeLogInMenuScreen(title: " الطلبات")
                      : Scaffold(
                          resizeToAvoidBottomInset: true,
                          appBar: fixxedAppBar("البروفايل"),
                          body: Stack(children: [
                            backgroundImage(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height),
                            SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(children: [
                                      Center(
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.greenAccent[100],
                                          radius: 60,
                                          backgroundImage: NetworkImage(cubit
                                                  .myProfileModel!
                                                  .data!
                                                  .photo ??
                                              "https://th.bing.com/th/id/OIP.eXWcaYbEtO2uuexHM8sAwwHaHa?pid=ImgDet&w=4000&h=4000&rs=1"),
                                        ), //CircleAvatar
                                      ),
                                      profileDataContainer(
                                          "الاسم",
                                          cubit.myProfileModel!.data!.name
                                              .toString()),
                                      const SizedBox(height: 32),
                                      profileDataContainer(
                                          "رقم الهاتف",
                                          cubit.myProfileModel!.data!.phone
                                              .toString()),
                                      const SizedBox(height: 32),
                                      profileDataContainer(
                                          "البريد الإلكتروني",
                                          cubit.myProfileModel!.data!.email
                                              .toString()),
                                      const SizedBox(height: 32),
                                      profileDataContainer("العنوان الحالي",
                                          cubit.adrees.toString()),
                                      const SizedBox(height: 32),
                                      myButton("تعديل بياناتي", "#1D71B8", () {
                                        navigateTo(
                                            context, const ProfileScreen());
                                      }),
                                      const SizedBox(height: 15),
                                      myButton("تسجيل الخروج", " #8B0000 ", () {
                                        cubit.logOutAccount(context);
                                      }),
                                      const SizedBox(height: 15),
                                      myButton("حذف حسابي", "#8B0000", () {
                                        cubit.deleteAccount(context);
                                      })
                                    ])))
                          ]))));
        });
  }
}
