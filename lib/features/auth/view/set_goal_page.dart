import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colours.dart';
import '../../../common/constants.dart';
import '../../../common/widgets/round_button.dart';

import '../controller/auth_controller.dart';

class SetGoalPage extends ConsumerStatefulWidget {
  const SetGoalPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetGoalPageState();
}

class _SetGoalPageState extends ConsumerState<SetGoalPage> {
  CarouselController buttonCarouselController = CarouselController();
  int goalIndex = 0;

  void setGoals() {
    ref.read(authControllerProvider.notifier).setGoals(
          context: context,
          goalIndex: goalIndex,
        );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: TColor.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: TColor.primaryColor1,
              ),
            )
          : SafeArea(
              child: Stack(
              children: [
                Center(
                  child: CarouselSlider(
                    items: goalArr
                        .map(
                          (gObj) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: TColor.primaryG,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: media.width * 0.1,
                              horizontal: 25,
                            ),
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Image.asset(
                                    gObj["image"].toString(),
                                    width: media.width * 0.5,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(
                                    height: media.width * 0.1,
                                  ),
                                  Text(
                                    gObj["title"].toString(),
                                    style: TextStyle(
                                        color: TColor.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Container(
                                    width: media.width * 0.1,
                                    height: 1,
                                    color: TColor.white,
                                  ),
                                  SizedBox(
                                    height: media.width * 0.02,
                                  ),
                                  Text(
                                    gObj["subtitle"].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.7,
                      aspectRatio: 0.74,
                      initialPage: 0,
                      onPageChanged: (index, reason) => setState(() {
                        goalIndex = index;
                      }),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  width: media.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Text(
                        "What is your goal ?",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "It will help us to choose a best\nprogram for you",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: TColor.gray, fontSize: 12),
                      ),
                      const Spacer(),
                      RoundButton(
                        title: "Confirm",
                        onPressed: () => setGoals(),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                    ],
                  ),
                )
              ],
            )),
    );
  }
}
