import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../features/auth/controller/auth_controller.dart';
import '../../features/community/controller/community_controller.dart';

import './round_button.dart';

import '../colours.dart';

import '../../models/community_model.dart';

class CommunityCell extends ConsumerWidget {
  final Community cObj;
  final int index;
  const CommunityCell({
    super.key,
    required this.index,
    required this.cObj,
  });

  void navigateToViewCommunity(BuildContext context) {
    Routemaster.of(context).push('/view-community/${cObj.id}');
  }

  void joinCommunity(BuildContext context, WidgetRef ref) {
    ref.read(communityControllerProvider.notifier).joinCommunity(
          communityId: cObj.id,
          context: context,
        );
  }

  void leaveCommunity(BuildContext context, WidgetRef ref) {
    ref.read(communityControllerProvider.notifier).leaveCommunity(
          communityId: cObj.id,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var media = MediaQuery.of(context).size;
    final user = ref.watch(userProvider)!;
    bool isEven = index % 2 == 0;
    return Container(
      margin: const EdgeInsets.all(8),
      width: media.width * 0.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEven
              ? [
                  TColor.primaryColor2.withOpacity(0.5),
                  TColor.primaryColor1.withOpacity(0.5)
                ]
              : [
                  TColor.secondaryColor2.withOpacity(0.5),
                  TColor.secondaryColor1.withOpacity(0.5)
                ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(75),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "assets/img/gym-3.png",
                height: media.width * 0.25,
                width: media.width * 0.3,
                fit: BoxFit.contain,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              cObj.name,
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '${cObj.members.length} Members',
              style: TextStyle(color: TColor.gray, fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  height: 25,
                  child: RoundButton(
                    fontSize: 12,
                    type: isEven
                        ? RoundButtonType.bgGradient
                        : RoundButtonType.bgSGradient,
                    title: "View",
                    onPressed: () => navigateToViewCommunity(context),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 25,
                  child: RoundButton(
                    fontSize: 12,
                    type: isEven
                        ? RoundButtonType.bgGradient
                        : RoundButtonType.bgSGradient,
                    title: cObj.members.contains(user.uid) ? "Leave" : "Join",
                    onPressed: cObj.admin == user.uid
                        ? null
                        : cObj.members.contains(user.uid)
                            ? () => leaveCommunity(context, ref)
                            : () => joinCommunity(context, ref),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
