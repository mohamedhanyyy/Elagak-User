import 'package:elagy_user_app/cubit/states.dart';
import 'package:elagy_user_app/modules/shopping/cart.dart';
import 'package:elagy_user_app/shared/appbar/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../shared/constant.dart';
import '../../shared/navigation/navigation.dart';

class FollowOrder extends StatelessWidget {
  const FollowOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, States) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                  child: Scaffold(
                      appBar: myAppBar(
                          "متابعة الطلب",
                          () => navigateTo(context, CartScreen()),
                          appBarIconCart,
                          context),
                      body: Stack(children: [
                        backgroundImage(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height),
                        SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container()))
                      ]))));
        });
  }
}
