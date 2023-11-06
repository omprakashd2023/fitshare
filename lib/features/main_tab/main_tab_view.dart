import 'package:fitshare/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/colours.dart';
import '../../common/widgets/tab_button.dart';

import './select_view.dart';

import '../home/home_view.dart';

import '../photo_progress/photo_progress_view.dart';

import '../profile/profile_view.dart';

import '../community/views/community_page.dart';

class MainTabView extends ConsumerStatefulWidget {
  const MainTabView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainTabViewState();
}

class _MainTabViewState extends ConsumerState<MainTabView> {
  int selectTab = 0;

  static const List<Widget> _pages = [
    HomeView(),
    SelectView(),
    PhotoProgressView(),
    ProfileView(),
    CommunityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: TColor.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: TColor.primaryColor1,
              ),
            )
          : PageTransitionSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: _pages[selectTab],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            setState(() {
              selectTab = 4;
            });
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Container(
              key: ValueKey<int>(selectTab),
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                gradient: selectTab == 4
                    ? LinearGradient(
                        colors: TColor.secondaryG,
                      )
                    : LinearGradient(
                        colors: TColor.primaryG,
                      ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: selectTab == 4
                    ? const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5, // Increase blur radius when selected
                        )
                      ]
                    : const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                        )
                      ],
              ),
              child: Icon(
                Icons.group,
                color: TColor.white,
                size: 35,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: BottomAppBar(
          key: ValueKey<int>(selectTab),
          child: Container(
            decoration: BoxDecoration(color: TColor.white, boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
            ]),
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabButton(
                    icon: "assets/img/home_tab.png",
                    selectIcon: "assets/img/home_tab_select.png",
                    isActive: selectTab == 0,
                    onTap: () {
                      setState(() {
                        selectTab = 0;
                      });
                    }),
                TabButton(
                    icon: "assets/img/activity_tab.png",
                    selectIcon: "assets/img/activity_tab_select.png",
                    isActive: selectTab == 1,
                    onTap: () {
                      setState(() {
                        selectTab = 1;
                      });
                    }),
                const SizedBox(
                  width: 40,
                ),
                TabButton(
                    icon: "assets/img/camera_tab.png",
                    selectIcon: "assets/img/camera_tab_select.png",
                    isActive: selectTab == 2,
                    onTap: () {
                      setState(() {
                        selectTab = 2;
                      });
                    }),
                TabButton(
                    icon: "assets/img/profile_tab.png",
                    selectIcon: "assets/img/profile_tab_select.png",
                    isActive: selectTab == 3,
                    onTap: () {
                      setState(() {
                        selectTab = 3;
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
