import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/custome_gradient_button.dart';
import '../../shared/HomePage/product_item.dart';
import '../../shared/HomePage/store_category.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/appbar/normal_app_bar_icon.dart';
import '../../shared/auth/make_login.dart';
import '../../shared/constant.dart';
import '../../shared/loading/loading_widget.dart';
import '../../shared/navigation/navigation.dart';
import '../../shared/network/local/cache_helper.dart';
import '../shopping/cart.dart';

class Store extends StatelessWidget {
  Store(this.id, {Key? key}) : super(key: key);
  String id;
  var size, height, width;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        size = MediaQuery.of(context).size;
        height = size.height;
        width = size.width;
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: cubit.onePharmacyModel == null
                  ? loadingWidget()
                  : Scaffold(
                      appBar: normalAppBarIcon(
                          cubit.onePharmacyModel!.data!.name.toString(), () {
                        cubit.getDataFromDataBase(
                            cubit.onePharmacyModel!.data!.id!.toInt());
                        navigateTo(context, CartScreen());
                      }, appBarIconCart, context),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              customGradientButton(
                                const Text("ابحث الان عن منتجاتك",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: myTextFormField(
                                          border: null,
                                          controller: searchController,
                                          context: context,
                                          focuscolor: HexColor("#34AAA0"),
                                          hint: "   ابحث ...",
                                          hintColor: Colors.white,
                                          inputType: TextInputType.text,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          debugPrint(
                                              "searchController is ${searchController.text}\nid is : $id");
                                          cubit.newSearch(
                                              searchController.text, id);
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: HexColor("#F9D923")),
                                          child: const Icon(Icons.search),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text("المنتجات",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(height: 8),
                              cubit.searchModel == null
                                  ? Column(
                                      children: [
                                        Container(
                                            height: 40,
                                            color: Colors.transparent,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: cubit.onePharmacyModel!
                                                  .data!.departments!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return categories(() {
                                                  cubit.changeCatIndex(index);
                                                },
                                                    cubit
                                                        .onePharmacyModel!
                                                        .data!
                                                        .departments![index]
                                                        .name
                                                        .toString(),
                                                    cubit.selectedCategoryIndex ==
                                                        index);
                                              },
                                            )),
                                        const SizedBox(height: 40),
                                        cubit.pharmacyMedicinesModel == null
                                            ? CircularProgressIndicator(
                                                color: HexColor("#04914F"))
                                            : GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 150,
                                                        childAspectRatio:
                                                            6 / 10,
                                                        crossAxisSpacing: 13,
                                                        mainAxisSpacing: 20),
                                                itemCount: cubit
                                                    .pharmacyMedicinesModel!
                                                    .paginate!
                                                    .data!
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return productItem(
                                                      cubit
                                                          .pharmacyMedicinesModel!
                                                          .paginate!
                                                          .data![index]
                                                          .name
                                                          .toString(),
                                                      context,
                                                      "${cubit.pharmacyMedicinesModel!.paginate!.data![index].pivot!.price.toString()} جنيه ",
                                                      // "${cubit.pharmacyMedicinesModel!.paginate!.data![index].price.toString()} جنيه ",
                                                      cubit
                                                          .pharmacyMedicinesModel!
                                                          .paginate!
                                                          .data![index]
                                                          .photo
                                                          .toString(),
                                                      "شراء",
                                                      CacheHelper.getData(
                                                                  key:
                                                                      'token') ==
                                                              null
                                                          ? () {
                                                              navigateTo(
                                                                  context,
                                                                  MakeLogInScreen(
                                                                      title:
                                                                          'الشراء'));
                                                            }
                                                          : () {
                                                              debugPrint(
                                                                  "title: ${cubit.pharmacyMedicinesModel!.paginate!.data![index].name} \nprice: ${cubit.pharmacyMedicinesModel!.paginate!.data![index].price}\nimage: ${cubit.pharmacyMedicinesModel!.paginate!.data![index].photo}\n quantity: 1\npharmacyID: ${cubit.onePharmacyModel!.data!.id!.toInt()}\nmedicineID: ${cubit.pharmacyMedicinesModel!.paginate!.data![index].id}");
                                                              cubit
                                                                  .insertToDatabase(
                                                                      title: cubit
                                                                          .pharmacyMedicinesModel!
                                                                          .paginate!
                                                                          .data![
                                                                              index]
                                                                          .name
                                                                          .toString(),
                                                                      price: cubit
                                                                          .pharmacyMedicinesModel!
                                                                          .paginate!
                                                                          .data![
                                                                              index]
                                                                          .pivot!
                                                                          .price
                                                                          .toString(),
                                                                      // price: cubit.pharmacyMedicinesModel!.paginate!.data![index].price.toString(),
                                                                      image: cubit
                                                                          .pharmacyMedicinesModel!
                                                                          .paginate!
                                                                          .data![
                                                                              index]
                                                                          .photo
                                                                          .toString(),
                                                                      quantity:
                                                                          1,
                                                                      pharmacyID: cubit
                                                                          .onePharmacyModel!
                                                                          .data!
                                                                          .id!
                                                                          .toInt(),
                                                                      medicineID: cubit
                                                                              .pharmacyMedicinesModel!
                                                                              .paginate!
                                                                              .data![index]
                                                                              .id ??
                                                                          1);
                                                              debugPrint(
                                                                  "cubit.onePharmacyModel!.data!.id!.toInt() ${cubit.onePharmacyModel!.data!.id!.toInt()}");
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "تم إضافة المنتج الي العربة");
                                                            });
                                                },
                                              ),
                                        /* if (cubit.pharmacyMedicinesModel!.paginate!.currentPage!.toInt() < cubit.pharmacyMedicinesModel!.paginate!.lastPage!.toInt())
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cubit.changeCatIndex(0);
                                            cubit.getMedicines(
                                                (cubit.pharmacyMedicinesModel!.paginate!.currentPage!.toInt())+1,
                                                true,
                                                cubit.onePharmacyModel!.data!.departments![cubit.selectedCategoryIndex].id.toString(),
                                                id);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                            child: const Icon(Icons.expand_circle_down, size: 35,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                             */
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        cubit.searchModel == null
                                            ? CircularProgressIndicator(
                                                color: HexColor("#04914F"))
                                            : GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 150,
                                                        childAspectRatio:
                                                            6 / 10,
                                                        crossAxisSpacing: 13,
                                                        mainAxisSpacing: 20),
                                                itemCount: cubit.searchModel!
                                                    .data!.data!.length,
                                                //cubit.pharmacyMedicinesModel!.paginate!.data!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return productItem(
                                                      cubit.searchModel!.data!
                                                          .data![index]!.name
                                                          .toString(),
                                                      context,
                                                      cubit
                                                          .searchModel!
                                                          .data!
                                                          .data![index]!
                                                          .pivot!
                                                          .price
                                                          .toString(),
                                                      cubit.searchModel!.data!
                                                          .data![index]!.photo
                                                          .toString(),
                                                      "شراء",
                                                      CacheHelper.getData(
                                                                  key:
                                                                      'token') ==
                                                              null
                                                          ? () {
                                                              navigateTo(
                                                                  context,
                                                                  MakeLogInScreen(
                                                                    title:
                                                                        'الشراء',
                                                                  ));
                                                            }
                                                          : () {
                                                              cubit.insertToDatabase(
                                                                  title: cubit
                                                                      .searchModel!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .name
                                                                      .toString(),
                                                                  price: cubit
                                                                      .searchModel!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .pivot!
                                                                      .price
                                                                      .toString(),
                                                                  image: cubit
                                                                      .searchModel!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .photo
                                                                      .toString(),
                                                                  quantity: 1,
                                                                  pharmacyID: cubit
                                                                      .searchModel!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .id!
                                                                      .toInt(),
                                                                  medicineID: cubit
                                                                      .searchModel!
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .pivot!
                                                                      .id!
                                                                      .toInt());
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "تم إضافة المنتج الي العربة");
                                                            });
                                                },
                                              ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
            ));
      },
    );
  }
}
