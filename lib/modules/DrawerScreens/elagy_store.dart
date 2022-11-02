import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/states.dart';
import '../../shared/appbar/fixxed_appbar.dart';
import '../../shared/auth/make_login_menu.dart';
import '../../shared/network/local/cache_helper.dart';

class ElagyStore extends StatelessWidget {
  const ElagyStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, States) {},
        builder: (context, States) {
          var cubit = HomeCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: CacheHelper.getData(key: 'token') == null
                    ? MakeLogInMenuScreen(title: "متجر علاجك")
                    : Scaffold(
                        appBar: fixxedAppBar("متجر علاجك"),
                      ),
              ));
        });
  }
}
