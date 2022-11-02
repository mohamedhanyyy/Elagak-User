import 'package:elagy_user_app/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/auth/make_login_menu.dart';
import '../../shared/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/shopping/previous_order.dart';

class PreviousOrder extends StatelessWidget {
  PreviousOrder({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        size = MediaQuery.of(context).size;
        height = size.height;
        width = size.width;
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: CacheHelper.getData(key: 'token') == null
                  ? MakeLogInMenuScreen(title: " الطلبات")
                  : cubit.userModelOrders == null
                      ? loadingWidget()
                      : Scaffold(
                          backgroundColor: HexColor("#FBFBFB"),
                          appBar: fixxedAppBar("الطلبيات"),
                          body: Stack(
                            children: [
                              backgroundImage(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height),
                              SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ListView.builder(
                                    itemCount:
                                        cubit.userModelOrders!.data!.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return myPreviousOrders(
                                          cubit.userModelOrders!.data![index].id
                                              .toString(),
                                          cubit.userModelOrders!.data![index]
                                              .date
                                              .toString(),
                                          () => cubit.getOneOrderData(
                                              cubit.userModelOrders!
                                                  .data![index].id
                                                  .toString(),
                                              context));
                                    },
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
