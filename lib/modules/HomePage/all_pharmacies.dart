import 'package:elagy_user_app/shared/drawer/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/HomePage/all_pharmacies.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/constant.dart';
import '../../shared/loading/empty_wifget.dart';
import '../../shared/loading/loading_widget.dart';
import '../../shared/navigation/navigation.dart';
import 'pharmacy_profile.dart';

var searchController = TextEditingController();

class PharmaciesScreen extends StatelessWidget {
  PharmaciesScreen({
    Key? key,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        bool isRefreshed = true;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: cubit.allPharmaciesModel == null
                ? loadingWidget()
                : cubit.allPharmaciesModel!.data!.datason!.isEmpty
                    ? const EmptyWidget(name: 'الصيدليات')
                    : Scaffold(
                        resizeToAvoidBottomInset: true,
                        appBar: fixxedAppBar(cubit.adrees),
                        body: RefreshIndicator(
                          onRefresh: () async {
                            cubit.pharmaciesSearchModel == null;
                            cubit.getCities();
                            cubit.getCurrentLocation();
                            navigateFinalTo(context, const HomeDrawer());
                          },
                          child: Stack(
                            children: [
                              backgroundImage(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text("مرحبا بكم في علاجك 🔥",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.black))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: myTextFormField(
                                              controller: searchController,
                                              context: context,
                                              focuscolor: Colors.white,
                                              hint: "اسم الصيدلية",
                                              hintColor: Colors.black,
                                              inputType: TextInputType.text,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              cubit.pharmaciesSearch(
                                                  search:
                                                      searchController.text);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 007, 165, 91),
                                                      Color.fromARGB(
                                                          255, 29, 113, 184)
                                                    ],
                                                  )),
                                              child: const Icon(
                                                Icons.search,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    isRefreshed == true &&
                                            cubit.pharmaciesSearchModel == null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: CustomScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              slivers: [
                                                SliverList(
                                                  delegate:
                                                      SliverChildBuilderDelegate(
                                                          (context, index) =>
                                                              buildPlaceItem(
                                                                  index,
                                                                  context,
                                                                  cubit
                                                                          .allPharmaciesModel!
                                                                          .data!
                                                                          .datason![
                                                                              index]
                                                                          .photo ??
                                                                      'https://th.bing.com/th/id/R.e10262585addf11fa80aa77e6210a931?rik=%2fVpDaX3%2fMyMGDA&pid=ImgRaw&r=0',
                                                                  cubit
                                                                      .allPharmaciesModel!
                                                                      .data!
                                                                      .datason![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  ' علي بعد ${cubit.allPharmaciesModel!.data!.datason![index].distance} كم ',
                                                                  () {
                                                                cubit.getCategories(cubit
                                                                    .allPharmaciesModel!
                                                                    .data!
                                                                    .datason![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                                navigateTo(
                                                                    context,
                                                                    PharmacyProfile(
                                                                      distance:
                                                                          'علي بعد\n${cubit.allPharmaciesModel!.data!.datason![index].distance} كم',
                                                                    ));
                                                              }, 1),
                                                          childCount: cubit
                                                              .allPharmaciesModel!
                                                              .data!
                                                              .datason!
                                                              .length),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: CustomScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              slivers: [
                                                SliverList(
                                                  delegate:
                                                      SliverChildBuilderDelegate(
                                                          (context, index) =>
                                                              buildPlaceItem(
                                                                  index,
                                                                  context,
                                                                  cubit
                                                                          .pharmaciesSearchModel!
                                                                          .paginate!
                                                                          .data![
                                                                              index]
                                                                          .photo
                                                                          .toString() ??
                                                                      'https://th.bing.com/th/id/R.e10262585addf11fa80aa77e6210a931?rik=%2fVpDaX3%2fMyMGDA&pid=ImgRaw&r=0',
                                                                  cubit
                                                                      .pharmaciesSearchModel!
                                                                      .paginate!
                                                                      .data![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  ' علي بعد ${cubit.pharmaciesSearchModel!.paginate!.data![index].distance.toString()} متر ',
                                                                  () {
                                                                cubit.getCategories(cubit
                                                                    .pharmaciesSearchModel!
                                                                    .paginate!
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                                navigateTo(
                                                                    context,
                                                                    PharmacyProfile(
                                                                        distance:
                                                                            ' علي بعد ${cubit.pharmaciesSearchModel!.paginate!.data![index].distance.toString()} متر '));
                                                              }, 1),
                                                          childCount: cubit
                                                              .pharmaciesSearchModel!
                                                              .paginate!
                                                              .data!
                                                              .length),
                                                ),
                                              ],
                                            ),
                                          ),
                                    cubit.allPharmaciesModel!.data!.currentPage!
                                                .toInt() <
                                            cubit.allPharmaciesModel!.data!
                                                .lastPage!
                                                .toInt()
                                        ? Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cubit.getPharmacies(
                                                        (cubit
                                                                .allPharmaciesModel!
                                                                .data!
                                                                .currentPage!
                                                                .toInt()) +
                                                            1,
                                                        true);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: const Icon(
                                                      Icons.expand_circle_down,
                                                      size: 35,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }
}
