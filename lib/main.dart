import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit/home_cubit.dart';
import 'modules/opening/offline.dart';
import 'modules/opening/splash.dart';
import 'shared/network/key/key.dart';
import 'shared/network/local/cache_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("notification");
  final routeFromMessage = message.data["route"];
  BuildContext globalContext = Global.materialKey.currentContext!;
  Navigator.of(globalContext).pushNamed(routeFromMessage);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: HexColor("#04914F")));
  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    debugPrint("notification");
    final routeFromMessage = event.data["route"];
    Fluttertoast.showToast(
      msg: "there is an update of $routeFromMessage go and check it",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("notification");
    final routeFromMessage = event.data["route"];
    BuildContext globalContext = Global.materialKey.currentContext!;
    Navigator.of(globalContext).pushNamed(routeFromMessage);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()
        ..getCities()
        ..getCurrentLocation()
        ..getAboutUs()
        ..getTopFan()
        ..createDataBase()
        ..getElagyStoreMedicines(1, false, "1"),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        theme: ThemeData(fontFamily: 'DIN Next LT Arabic'),
        title: "علاجك - 3elagk",
        color: HexColor("#04914F"),
        home: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return const SplashScreen();
            } else {
              return const OfflineWidget();
            }
          },
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
