import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/appbar/normal_app_bar.dart';
import '../../shared/constant.dart';
import '../../shared/shopping/cart_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  var codeController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
              child: Scaffold(
            appBar: noramlAppBar("عربة التسوق"),
            body: Stack(
              children: [
                backgroundImage(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        cubit.myItems.isEmpty
                            ? const Center(child: Text("لم تقم بشراء شيء بعد"))
                            : ListView.builder(
                                itemCount: cubit.myItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return cartItems(
                                    context,
                                    cubit.myItems[index]["image"].toString(),
                                    cubit.myItems[index]["title"].toString(),
                                    cubit.myItems[index]["price"].toString(),
                                    cubit.myItems[index]["quantity"].toString(),
                                    // plus
                                    () {
                                      debugPrint(
                                          "all list before ${cubit.myItems}");
                                      debugPrint(
                                          "only item before ${cubit.myItems[index]}");
                                      int x = cubit.myItems[index]["quantity"];
                                      cubit.updateQuery(
                                          ++x,
                                          cubit.myItems[index]['id'],
                                          cubit.onePharmacyModel!.data!.id!
                                              .toInt());
                                      debugPrint(
                                          "all list after ${cubit.myItems}");
                                      debugPrint(
                                          "only item after ${cubit.myItems[index]}");
                                      debugPrint(cubit.myItems[index]
                                              ["quantity"]
                                          .toString());
                                    },
                                    // minus
                                    () {
                                      debugPrint(
                                          "all list before ${cubit.myItems}");
                                      debugPrint(
                                          "only item before ${cubit.myItems[index]}");
                                      int x = cubit.myItems[index]["quantity"];
                                      cubit.updateQuery(
                                          --x,
                                          cubit.myItems[index]['id'],
                                          cubit.onePharmacyModel!.data!.id!
                                              .toInt());
                                      debugPrint(
                                          "all list after ${cubit.myItems}");
                                      debugPrint(
                                          "only item after ${cubit.myItems[index]}");
                                    },
                                    // delete
                                    () {
                                      cubit.deleteRow(
                                          id: cubit.myItems[index]["id"],
                                          index: index,
                                          pharmacyID: cubit
                                              .onePharmacyModel!.data!.id!
                                              .toInt());
                                    },
                                  );
                                },
                              ),
                        Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("اضافة كود الخصم",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: HexColor("#404040"))),
                            )),
                        myTextFormField(
                          context: context,
                          controller: codeController,
                          hint: "123456789",
                          inputType: TextInputType.text,
                          /*suffixIcon: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                onPressed: () {

                                },
                                color: HexColor("#04914F"),
                                child: const Text("تفعيل",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)))*/
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            myImage(
                                "assets/images/order/Icon feather-map-pin.png"),
                            const SizedBox(width: 14),
                            Text(
                              "التوصيل الى",
                              style: TextStyle(
                                  fontSize: 16, color: HexColor("#404040")),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) => Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            elevation: 0.0,
                                            backgroundColor: Colors.transparent,
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        blurRadius: 10.0,
                                                        offset:
                                                            Offset(0.0, 10.0),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      // To make the card compact
                                                      children: <Widget>[
                                                        const SizedBox(
                                                            height: 16.0),
                                                        const Text(
                                                            "أكتب عنوانك بالتفصيل"),
                                                        Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    20),
                                                            child: myTextFormField(
                                                                context:
                                                                    context,
                                                                controller:
                                                                    addressController,
                                                                hint:
                                                                    "لا تنس رقم العقار و رقم الشقة و العلامة المميزة",
                                                                lines: 3)),
                                                        myButton("حفظ العنوان",
                                                            "#1D71B8", () {
                                                          cubit.changeAdress(
                                                              addressController
                                                                  .text);
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        }),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ));
                                },
                                child: Text(cubit.adrees,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                              ),
                              const Icon(Icons.edit, size: 14),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        // const SizedBox(height: 20),
                        // priceSumary(cubit.totalPrice, 15),
                        const SizedBox(height: 25),
                        myButton("تأكيد الشراء", "#1D71B8", () {
                          var extractMap = cubit.myItems
                              .map((element) => Map.fromEntries([
                                    MapEntry(
                                        'medicine_id', element['medicineID']),
                                    MapEntry('amount', element['quantity']),
                                  ]))
                              .toList();
                          print("my order items is : $extractMap");
                          extractMap.isNotEmpty
                              ? cubit.cartOrder(
                                  context: context,
                                  pharmID:
                                      cubit.onePharmacyModel!.data!.id!.toInt(),
                                  pharmacy_id: cubit.onePharmacyModel!.data!.id!
                                      .toString(),
                                  medicines: extractMap,
                                  coupon: codeController.text.toString(),
                                  addressdelv:
                                      addressController.text.toString() == ""
                                          ? cubit.adrees.toString()
                                          : addressController.text.toString())
                              : Fluttertoast.showToast(msg: "cart is empty");
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
