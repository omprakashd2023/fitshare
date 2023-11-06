import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../common/colours.dart';
import '../../../common/widgets/community_cell.dart';
import '../../../common/widgets/challenge_tile.dart';
import '../../../common/widgets/round_button.dart';

import './delegate/search_delegate.dart';

import '../controller/community_controller.dart';
// import '../../auth/controller/auth_controller.dart';

class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  List communityArr = [
    {
      "name": "CardoStrikers",
      "image": "assets/img/gym-1.png",
      "members": "120+",
    },
    {
      "name": "Joggers",
      "image": "assets/img/gym-2.png",
      "members": "130+",
    },
    {
      "name": "Abs Strikers",
      "image": "assets/img/gym-3.png",
      "members": "120+",
    },
    {
      "name": "Yoga Freaks",
      "image": "assets/img/gym-4.png",
      "members": "130+",
    },
  ];
  List popularChallengesArr = [
    {
      "name": "Full Body Workout",
      "image": "assets/img/Workout1.png",
      "duration": "7",
      "time": "20",
      "progress": 0.3,
      "community": "CardioStrikers",
      "members": 125
    },
    {
      "name": "Lower Body Workout",
      "image": "assets/img/Workout2.png",
      "duration": "10",
      "time": "30",
      "progress": 0.4,
      "community": "Joogers",
      "members": 137
    },
    {
      "name": "Ab Workout",
      "image": "assets/img/Workout3.png",
      "duration": "15",
      "time": "40",
      "progress": 0.7,
      "community": "CardioStrikers",
      "members": 125
    },
  ];

  bool isOpened = true;

  void _toggle() {
    setState(() {
      isOpened = !isOpened;
    });
  }

  void showSearchDelegate() {
    showSearch(
      context: context,
      delegate: SearchDelegateWidget(ref: ref),
    );
  }

  void navigateToCreateCommunity() {
    Routemaster.of(context).push("/create-community");
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Community",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () => showSearchDelegate(),
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.search,
                color: TColor.black,
                size: 25,
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
      backgroundColor: TColor.white,
      floatingActionButton: InkWell(
        onTap: () => navigateToCreateCommunity(),
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.secondaryG),
              borderRadius: BorderRadius.circular(27.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ]),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),
      body: ref.watch(getAllCommunitiesProvider).when(
            data: (communities) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (communities.isEmpty && isOpened)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFE5E5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: TColor.white,
                                  borderRadius: BorderRadius.circular(30)),
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/img/date_notifi.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Reminder!",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "You haven't joined any community yet.",
                                      style: TextStyle(
                                        color: TColor.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              height: 60,
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () => _toggle(),
                                icon: Icon(
                                  Icons.close,
                                  color: TColor.gray,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                      bottom: 7,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      color: TColor.primaryColor2.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "View Communities",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 70,
                          height: 25,
                          child: RoundButton(
                            title: "View",
                            type: RoundButtonType.bgGradient,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  if (communities.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        "Popular Communities",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.55,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: communities.length,
                          itemBuilder: (context, index) {
                            var cObj = communities[index];
                            return CommunityCell(
                              cObj: cObj,
                              index: index,
                            );
                          }),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Challenges",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See More",
                            style: TextStyle(
                              color: TColor.gray,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: popularChallengesArr.length,
                    itemBuilder: (context, index) {
                      var cObj = popularChallengesArr[index] as Map? ?? {};
                      return InkWell(
                        onTap: () {},
                        child: ChallengeTile(cObj: cObj),
                      );
                    },
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) {
              return const Center(
                child: Text("Error"),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
