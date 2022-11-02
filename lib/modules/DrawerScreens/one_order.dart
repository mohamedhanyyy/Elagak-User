import 'package:elagy_user_app/cubit/states.dart';
import 'package:elagy_user_app/shared/appbar/normal_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../shared/constant.dart';

class OneOrderDetails extends StatelessWidget {
  OneOrderDetails({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, states) {},
        builder: (context, states) {
          size = MediaQuery.of(context).size;
          height = size.height;
          width = size.width;
          var cubit = HomeCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: Scaffold(
                    backgroundColor: HexColor("#FBFBFB"),
                    appBar: noramlAppBar("تفاصيل الطلب"),
                    body: RefreshIndicator(
                      onRefresh: () => cubit.refreshOneOrderData(
                          cubit.oneOrderModel!.data!.id.toString()),
                      child: SingleChildScrollView(
                        child: Stack(children: [
                          backgroundImage(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                        primary: HexColor("#04914F"))),
                                child: Stepper(
                                  currentStep: cubit.steperIndex,
                                  steps: cubit.createSteps(),
                                  onStepCancel: cubit.CancleStep(),
                                  onStepContinue: cubit.ContaineStep(),
                                  onStepTapped: ((value) =>
                                      cubit.TappedStep(value)),
                                  controlsBuilder: (BuildContext context,
                                          ControlsDetails details) =>
                                      const SizedBox(),
                                ),
                              ))
                        ]),
                      ),
                    )),
              ));
        });
  }
}
