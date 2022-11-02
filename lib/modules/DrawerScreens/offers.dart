import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/shopping/offer_item.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                appBar: fixxedAppBar("العروض"),
                body: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text("صيدلية 19011",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 6 / 10,
                                  crossAxisSpacing: 13,
                                  mainAxisSpacing: 20),
                          itemCount: 26,
                          itemBuilder: (BuildContext context, int index) {
                            return offerProductItem(
                                "product name",
                                " 15.99 \$",
                                "5.56 \$",
                                "assets/images/profile/ل.png",
                                "خصم 15%",
                                "إضافة الي العربة",
                                () {});
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ));
      },
    );
  }
}
