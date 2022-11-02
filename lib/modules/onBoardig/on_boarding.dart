import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/onBoardingModel/on_boarding_item.dart';
import '../../shared/constant.dart';
import '../../shared/drawer/home_drawer.dart';
import '../../shared/navigation/navigation.dart';
import '../../shared/network/local/cache_helper.dart';

class BoardingModel {
  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
    required this.color,
    required this.indicatorColor,
    required this.floatingButtonColor,
  });

  final String body;
  final String color;
  final String image;
  final String indicatorColor;
  final String title;
  final String floatingButtonColor;
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding/1/image.png',
        title: 'هنوصلك في اي مكان',
        body: '',
        color: "#04914F",
        indicatorColor: "#48DF99",
        floatingButtonColor: "#45DC95"),
    BoardingModel(
        image: 'assets/images/onboarding/2/image.png',
        title: 'هتلاقينا جانبك في كل مكان',
        body: '',
        color: "#1D71B8",
        indicatorColor: "#91C8FF",
        floatingButtonColor: "#1ECEE9"),
    BoardingModel(
        image: 'assets/images/onboarding/3/image.png',
        title: 'جميع انواع الادويه ومستحضرات التجميل في مكان واحد',
        body: '',
        color: "#EB5353",
        indicatorColor: "#FF9797",
        floatingButtonColor: "#FF7171"),
  ];

  bool isLast = false;
  var size, height, width;

  void submit() {
    CacheHelper.putData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateFinalTo(
          context,
          HomeDrawer(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: boardController,
        itemCount: boarding.length,
        onPageChanged: (int index) {
          if (index == boarding.length - 1) {
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
        },
        itemBuilder: (context, index) => Scaffold(
              backgroundColor: HexColor(boarding[index].color),
              appBar: AppBar(
                backgroundColor: HexColor(boarding[index].color),
                elevation: 0,
                actions: [
                  TextButton(
                    onPressed: () {
                      submit();
                    },
                    child: const Text("SKip",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              ),
              body: Stack(children: [
                backgroundImage(width, height),
                Column(children: [
                  Expanded(
                    child: OnBoardingItem(
                        image: boarding[index].image,
                        body: boarding[index].body,
                        title: boarding[index].title),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SmoothPageIndicator(
                            controller: boardController,
                            effect: ExpandingDotsEffect(
                              dotColor: Colors.white,
                              activeDotColor:
                                  HexColor(boarding[index].indicatorColor),
                              dotHeight: 10,
                              expansionFactor: 4,
                              dotWidth: 10,
                              spacing: 5.0,
                            ),
                            count: boarding.length,
                          ),
                          const Spacer(),
                          FloatingActionButton(
                            backgroundColor:
                                HexColor(boarding[index].floatingButtonColor),
                            onPressed: () {
                              if (isLast) {
                                submit();
                              } else {
                                boardController.nextPage(
                                  duration: const Duration(
                                    milliseconds: 750,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              }
                            },
                            child: const Icon(Icons.arrow_forward_outlined),
                          ),
                        ],
                      )),
                ])
              ]),
            ));
  }
}
