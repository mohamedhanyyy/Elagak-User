import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../shared/drawer/home_drawer.dart';
import '../../shared/navigation/navigation.dart';
import '../../shared/network/local/cache_helper.dart';
import '../onBoardig/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _controller =
        VideoPlayerController.asset("assets/images/newlogo/intro.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(false);
      Timer(const Duration(milliseconds: 1000), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
      navigateFinalTo(
          context,
          CacheHelper.getData(key: 'onBoarding') == null
              ? const OnBoarding()
              : const HomeDrawer()); //  PharmaciesScreen());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 1.0,
      duration: const Duration(milliseconds: 3000),
      child: VideoPlayer(_controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
          ],
        ),
      ),
    );
  }
}
