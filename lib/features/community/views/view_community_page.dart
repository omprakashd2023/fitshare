import 'package:fitshare/features/community/controller/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../common/colours.dart';
import '../../../common/widgets/icon_title_next_row.dart';
import '../../../common/widgets/round_button.dart';
import '../../../common/widgets/exercises_set_section.dart';
import '../../auth/controller/auth_controller.dart';

class ViewCommunityPage extends ConsumerStatefulWidget {
  final String communityId;
  const ViewCommunityPage({
    super.key,
    required this.communityId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewCommunityPageState();
}

class _ViewCommunityPageState extends ConsumerState<ViewCommunityPage> {
  List latestArr = [
    {
      "image": "assets/img/Workout1.png",
      "title": "Fullbody Workout",
      "time": "Today, 03:00pm"
    },
    {
      "image": "assets/img/Workout2.png",
      "title": "Upperbody Workout",
      "time": "June 05, 02:00pm"
    },
  ];

  List exercisesArr = [
    {
      "name": "Set 1",
      "set": [
        {"image": "assets/img/img_1.png", "title": "Warm Up", "value": "05:00"},
        {
          "image": "assets/img/img_2.png",
          "title": "Jumping Jack",
          "value": "12x"
        },
        {"image": "assets/img/img_1.png", "title": "Skipping", "value": "15x"},
        {"image": "assets/img/img_2.png", "title": "Squats", "value": "20x"},
        {
          "image": "assets/img/img_1.png",
          "title": "Arm Raises",
          "value": "00:53"
        },
        {
          "image": "assets/img/img_2.png",
          "title": "Rest and Drink",
          "value": "02:00"
        },
      ],
    },
    {
      "name": "Set 2",
      "set": [
        {"image": "assets/img/img_1.png", "title": "Warm Up", "value": "05:00"},
        {
          "image": "assets/img/img_2.png",
          "title": "Jumping Jack",
          "value": "12x"
        },
        {"image": "assets/img/img_1.png", "title": "Skipping", "value": "15x"},
        {"image": "assets/img/img_2.png", "title": "Squats", "value": "20x"},
        {
          "image": "assets/img/img_1.png",
          "title": "Arm Raises",
          "value": "00:53"
        },
        {
          "image": "assets/img/img_2.png",
          "title": "Rest and Drink",
          "value": "02:00"
        },
      ],
    }
  ];

  void navigateToViewMembers() {
    Routemaster.of(context).push('/${widget.communityId}/members');
  }

  void navigateToChatRoom() {
    Routemaster.of(context).push('/${widget.communityId}/chat');
  }

  void joinCommunity() {
    ref.read(communityControllerProvider.notifier).joinCommunity(
          communityId: widget.communityId,
          context: context,
        );
  }

  void leaveCommunity() {
    ref.read(communityControllerProvider.notifier).leaveCommunity(
          communityId: widget.communityId,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final user = ref.watch(userProvider)!;
    return ref.watch(getCommunityByIdProvider(widget.communityId)).when(
          data: (community) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: TColor.primaryG)),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      elevation: 0,
                      leading: InkWell(
                        onTap: () => Routemaster.of(context).pop(),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.lightGray,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            "assets/img/back_btn.png",
                            width: 15,
                            height: 15,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      actions: [
                        InkWell(
                          onTap: () => navigateToChatRoom(),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: TColor.lightGray,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/img/chat.png",
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: TColor.lightGray,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/img/more_btn.png",
                              width: 15,
                              height: 15,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      elevation: 0,
                      leadingWidth: 0,
                      leading: Container(),
                      expandedHeight: media.width * 0.5,
                      flexibleSpace: Stack(
                        children: <Widget>[
                          CustomPaint(
                            size: Size(
                              double.infinity,
                              media.width * 0.8,
                            ),
                            painter: CirclesPainter(),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/img/gym-2.png",
                              height: media.width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 50,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: TColor.gray.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          community.name,
                                          style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "${community.members.length} Members | 7+ Ongoing Challenge \n${community.location}",
                                          style: TextStyle(
                                            color: TColor.gray,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: community.admin == user.uid
                                        ? null
                                        : community.members.contains(user.uid)
                                            ? () => leaveCommunity()
                                            : () => joinCommunity(),
                                    child: Text(
                                      community.members.contains(user.uid)
                                          ? "Leave"
                                          : "Join",
                                      style: TextStyle(
                                        color: community.admin == user.uid
                                            ? Colors.redAccent
                                            : TColor.primaryColor2,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              IconTitleNextRow(
                                icon: "assets/img/time.png",
                                title: "Scheduled Workout",
                                time: "5/25, 09:00 AM",
                                color: TColor.primaryColor2.withOpacity(0.3),
                                onPressed: () {},
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              IconTitleNextRow(
                                icon: "assets/img/difficulity.png",
                                title: "Challenge Difficulty",
                                time: "Beginner",
                                color: TColor.secondaryColor2.withOpacity(0.3),
                                onPressed: () {},
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Moderators",
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => navigateToViewMembers(),
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                        color: TColor.primaryColor2,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: media.width * 0.5,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: community.members.length,
                                  itemBuilder: (context, index) {
                                    var memberId = community.members[index];
                                    return ref
                                        .watch(getUserDataProvider(memberId))
                                        .when(
                                          data: (userData) {
                                            return Container(
                                              margin: const EdgeInsets.all(8),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height:
                                                            media.width * 0.35,
                                                        width:
                                                            media.width * 0.35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              TColor.lightGray,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Image.asset(
                                                          "assets/img/u1.png",
                                                          width:
                                                              media.width * 0.2,
                                                          height:
                                                              media.width * 0.2,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          userData.name!,
                                                          style: TextStyle(
                                                            color: TColor.black,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  if (community.admin ==
                                                      memberId)
                                                    Positioned(
                                                      top: 8,
                                                      left: 5,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: TColor
                                                              .primaryColor1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Text(
                                                          "Admin",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (community.moderators
                                                          .contains(memberId) &&
                                                      community.admin !=
                                                          memberId)
                                                    Positioned(
                                                      top: 8,
                                                      left: 5,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: TColor
                                                              .secondaryColor1,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Text(
                                                          "Moderator",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 8,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            );
                                          },
                                          loading: () => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          error: (error, stackTrace) =>
                                              const Center(
                                            child: Text("Error"),
                                          ),
                                        );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recommended Exercises",
                                    style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "2 Sets",
                                      style: TextStyle(
                                          color: TColor.gray, fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: exercisesArr.length,
                                itemBuilder: (context, index) {
                                  var sObj = exercisesArr[index] as Map? ?? {};
                                  return ExercisesSetSection(
                                    sObj: sObj,
                                    onPressed: (obj) {},
                                  );
                                },
                              ),
                              SizedBox(
                                height: media.width * 0.1,
                              ),
                            ],
                          ),
                        ),
                        if (!community.members.contains(user.uid))
                          SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RoundButton(
                                    title: "Join Community",
                                    onPressed: () => joinCommunity(),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => Scaffold(
            body: const Center(
              child: CircularProgressIndicator(),
            ),
            backgroundColor: TColor.white,
          ),
          error: (error, stackTrace) => const Center(
            child: Text("Error"),
          ),
        );
  }
}

class CirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    const radius = 20.0;

    for (double x = -radius; x < size.width + radius; x += 60) {
      for (double y = -radius; y < size.height + radius; y += 60) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
