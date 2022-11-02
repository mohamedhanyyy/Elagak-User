import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/HomePage/all_pharmacies.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/constant.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                appBar: fixxedAppBar("العملاء المميزين"),
                body: Stack(
                  children: [
                    backgroundImage(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: cubit.topFanModel!.data!.length == 0
                            ? const Center(
                                child: Text(
                                    "كن الأول بقائمة العملاء المميزين بكثرة مشترياتك\nو أحصل علي هديتك فورا"))
                            : ListView.builder(
                                itemCount: cubit.topFanModel!.data!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return buildPlaceItem(
                                      index,
                                      context,
                                      "https://th.bing.com/th/id/R.0facfebcb8eaeb96ffd0126b60f40681?rik=BTZNBRK1u94TPg&pid=ImgRaw&r=0",
                                      cubit.topFanModel!.data![index].name
                                          .toString(),
                                      "قيمة المشتريات : ${cubit.topFanModel!.data![index].purchaseTotal.toString()}",
                                      () {},
                                      5);
                                }),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
