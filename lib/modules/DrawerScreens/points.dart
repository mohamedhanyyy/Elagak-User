import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/Button/custome_gradient_button.dart';
import '../../shared/HomePage/product_item.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/auth/make_login_menu.dart';
import '../../shared/constant.dart';
import '../../shared/network/local/cache_helper.dart';

class Points extends StatelessWidget {
  Points({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        size = MediaQuery.of(context).size;
        height = size.height;
        width = size.width;
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: CacheHelper.getData(key: 'token') == null
                  ? MakeLogInMenuScreen(title: "النقاط")
                  : Scaffold(
                      appBar: fixxedAppBar("النقاط"),
                      body: Stack(
                        children: [
                          backgroundImage(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  customGradientButton(
                                    const Text("عدد النقاط",
                                        style: TextStyle(
                                            fontSize: 27,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    const Text("150 نقطة",
                                        style: TextStyle(
                                            fontSize: 27,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  const SizedBox(height: 20),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("منتجات لإستبدال النقاط",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  const SizedBox(height: 15),
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 150,
                                            childAspectRatio: 6 / 10,
                                            crossAxisSpacing: 13,
                                            mainAxisSpacing: 20),
                                    itemCount: 26,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return productItem(
                                          "product name",
                                          context,
                                          " 15 نقطة",
                                          "assets/images/profile/ل.png",
                                          "استبدال",
                                          () {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ));
      },
    );
  }
}
