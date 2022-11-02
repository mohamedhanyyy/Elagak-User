import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/aboutContactUS/about_us_data.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/constant.dart';
import '../../shared/loading/loading_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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
                appBar: fixxedAppBar("عن التطبيق"),
                body: cubit.aboutUsModel == null
                    ? loadingWidget()
                    : Stack(
                        children: [
                          backgroundImage(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  aboutUSTitle(
                                      "assets/images/about_us/info(1).png",
                                      "من نحن"),
                                  defaultSizedBoxSmall(),
                                  aboutUsText(cubit.aboutUsModel!.data!.aboutUs
                                      .toString()),
                                  defaultSizedBoxBig(),
                                  aboutUSTitle(
                                      "assets/images/about_us/visibility.png",
                                      "روئيتنا"),
                                  defaultSizedBoxSmall(),
                                  aboutUsText(cubit
                                      .aboutUsModel!.data!.ourVision
                                      .toString()),
                                  defaultSizedBoxBig(),
                                  aboutUSTitle(
                                      "assets/images/about_us/refresh.png",
                                      "الاصدار"),
                                  defaultSizedBoxSmall(),
                                  Text(
                                    "1.0.0",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor("#5F5F5F")),
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

  SizedBox defaultSizedBoxBig() {
    return const SizedBox(
      height: 40,
    );
  }

  SizedBox defaultSizedBoxSmall() {
    return const SizedBox(
      height: 20,
    );
  }
}
