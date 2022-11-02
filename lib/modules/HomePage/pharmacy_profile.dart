// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button.dart';
import '../../shared/appbar/normal_app_bar_icon.dart';
import '../../shared/auth/make_login.dart';
import '../../shared/constant.dart';
import '../../shared/loading/image_wifget.dart';
import '../../shared/loading/loading_widget.dart';
import '../../shared/navigation/navigation.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/shopping/profile_categories.dart';
import '../shopping/cart.dart';
import '../shopping/make_order.dart';
import 'pharmacy_store.dart';

class PharmacyProfile extends StatelessWidget {
  PharmacyProfile({required this.distance, Key? key}) : super(key: key);

  String distance;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: cubit.onePharmacyModel == null
                ? loadingWidget()
                : SafeArea(
                    child: Scaffold(
                    backgroundColor: HexColor("#FBFBFB"),
                    appBar: normalAppBarIcon(
                        cubit.onePharmacyModel!.data!.name.toString(), () {
                      cubit.getDataFromDataBase(
                          cubit.onePharmacyModel!.data!.id!.toInt());
                      navigateTo(context, CartScreen());
                    }, appBarIconCart, context),
                    body: Stack(
                      children: [
                        backgroundImage(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 260,
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: defaultNetworkImg(
                                                context,
                                                double.infinity,
                                                double.infinity,
                                                cubit.onePharmacyModel!.data!
                                                    .photo
                                                    .toString(),
                                                BoxFit.fitWidth,
                                                0,
                                                50),
                                          )),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 5,
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .90,
                                              height: 190,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                      cubit.onePharmacyModel!
                                                          .data!.name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 24)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                          "assets/images/profile/Iconfeather-map-pin.png"),
                                                      const SizedBox(width: 8),
                                                      InkWell(
                                                        onTap: () {
                                                          cubit.launchMap(
                                                              lat: cubit
                                                                  .onePharmacyModel!
                                                                  .data!
                                                                  .latitude
                                                                  .toString(),
                                                              lng: cubit
                                                                  .onePharmacyModel!
                                                                  .data!
                                                                  .longitude
                                                                  .toString());
                                                        },
                                                        child: Text(
                                                            cubit
                                                                .onePharmacyModel!
                                                                .data!
                                                                .location
                                                                .toString(),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: HexColor(
                                                                    "#484848"))),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/profile/kkj.png"),
                                                        Expanded(
                                                          child: Text(distance,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                        ),
                                                        const Spacer(),
                                                        Image.asset(
                                                            "assets/images/profile/svgexport-6(3).png"),
                                                        const Text(
                                                            "توصيل طلب \n 30 دقيقة",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                CustomScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                          (context, index) =>
                                              buildGategoryPharmacyItem(
                                                  index,
                                                  context,
                                                  'https://th.bing.com/th/id/R.e10262585addf11fa80aa77e6210a931?rik=%2fVpDaX3%2fMyMGDA&pid=ImgRaw&r=0',
                                                  "Store", () {
                                                // cubit.changeCatIndex(0);
                                                cubit.getMedicines(
                                                    1,
                                                    false,
                                                    cubit
                                                        .onePharmacyModel!
                                                        .data!
                                                        .departments![cubit
                                                            .selectedCategoryIndex]
                                                        .id
                                                        .toString(),
                                                    cubit.onePharmacyModel!
                                                        .data!.id
                                                        .toString());
                                                navigateTo(
                                                    context,
                                                    Store(cubit
                                                        .onePharmacyModel!
                                                        .data!
                                                        .id
                                                        .toString()));
                                              }, 1),
                                          childCount: 1),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                if (cubit.onePharmacyModel!.data!.orderByPhoto!
                                        .toInt() ==
                                    1)
                                  myButton("اطلب بالصورة او الروشتة", "#1D71B8",
                                      () {
                                    navigateTo(
                                        context,
                                        CacheHelper.getData(key: 'token') ==
                                                null
                                            ? MakeLogInScreen(title: 'الشراء')
                                            : MakeOrder(
                                                cubit.onePharmacyModel!.data!
                                                    .name
                                                    .toString(),
                                                cubit.onePharmacyModel!.data!.id
                                                    .toString(),
                                              ));
                                  })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
      },
    );
  }
}
