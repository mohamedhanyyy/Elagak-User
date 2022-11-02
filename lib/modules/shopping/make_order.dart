import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/button.dart';
import '../../shared/TextForm/text_form_field.dart';
import '../../shared/appbar/custom_appbar.dart';
import '../../shared/constant.dart';
import '../../shared/navigation/navigation.dart';
import 'cart.dart';

class MakeOrder extends StatelessWidget {
  MakeOrder(this.pharmacyName, this.pharmacyId, {Key? key}) : super(key: key);

  final String pharmacyName;
  final String pharmacyId;

  @override
  Widget build(BuildContext context) {
    var orderController = TextEditingController();
    var codeController = TextEditingController();
    var addressController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: Scaffold(
              appBar: customAppBarIcon(
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("طلب الدواء",
                            style: TextStyle(
                                fontSize: 22,
                                color: HexColor("#000000"),
                                fontWeight: FontWeight.w500)),
                        myImage("assets/images/svgexport-6.png"),
                      ],
                    ),
                  ), () {
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
                                        builder: (BuildContext context) =>
                                            Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              elevation: 0.0,
                                              backgroundColor:
                                                  Colors.transparent,
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
                                                          myButton(
                                                              "حفظ العنوان",
                                                              "#1D71B8", () {
                                                            cubit.changeAdress(
                                                                addressController
                                                                    .text);
                                                            Navigator.of(
                                                                    context)
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
                          Row(
                            children: [
                              myImage("assets/images/order/phamacy.png"),
                              const SizedBox(width: 14),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text("اسم الصيدلية",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(pharmacyName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          const Padding(
                              padding: EdgeInsets.all(16),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("اكتب طلبك يدويا",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600)),
                              )),
                          myTextFormField(
                            context: context,
                            lines: 5,
                            controller: orderController,
                          ),
                          const SizedBox(height: 16),
                          Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: const Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                            ),
                            const Text("أو"),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 10.0),
                                  child: const Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                            ),
                          ]),
                          DottedBorder(
                            color: HexColor("#04914F"),
                            strokeWidth: 3,
                            radius: const Radius.circular(20),
                            borderType: BorderType.RRect,
                            dashPattern: const [10, 6],
                            // 10 width, 6 space width
                            child: Container(
                              //inner container
                              height: 80,
                              //height of inner container
                              width: double.infinity,
                              //width to 100% match to parent container.
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: HexColor("#F1F8FF")),
                              child: InkWell(
                                onTap: () => cubit.pickImage(),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      myImage("assets/images/icons.png"),
                                      const SizedBox(width: 10),
                                      Text(
                                          cubit.imageePAth == null
                                              ? "إضافة صورة أو روشتة"
                                              : "تم إضافة الصورة الخاصة بك",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: HexColor("#404040")))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          cubit.isLoadingUpload == false
                              ? myButton("تاكيد الطلب", "#1D71B8", () {
                                  cubit.upload(
                                      latitude: cubit.latitude,
                                      longitude: cubit.longitude,
                                      pharmacyId: pharmacyId,
                                      imageFile: cubit.imageePAth,
                                      description: orderController.text,
                                      adress: addressController.text,
                                      context: context);
                                })
                              : CircularProgressIndicator(
                                  color: HexColor("#1D71B8")),
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
