import 'package:fitshare/features/community/controller/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../common/colours.dart';

import '../../auth/controller/auth_controller.dart';

class ViewMembersPage extends ConsumerStatefulWidget {
  final String communityId;
  const ViewMembersPage({super.key, required this.communityId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewMembersPageState();
}

class _ViewMembersPageState extends ConsumerState<ViewMembersPage> {
  bool isEdit = false;
  void _toggle() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void removeMember({
    required String userId,
    required String currentUserId,
  }) {
    ref.read(communityControllerProvider.notifier).removeMember(
          communityId: widget.communityId,
          userId: userId,
          currentUserId: currentUserId,
          context: context,
        );
    Routemaster.of(context).pop();
  }

  void addModerator({
    required String userId,
    required String currentUserId,
  }) {
    ref.read(communityControllerProvider.notifier).addModerator(
          communityId: widget.communityId,
          userId: userId,
          currentUserId: currentUserId,
          context: context,
        );
    Routemaster.of(context).pop();
  }

  void _removeMemberDialog({
    required String userName,
    required String userId,
    required String currentUserId,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Remove $userName from community?",
          style: TextStyle(
            color: TColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Are you sure you want to remove $userName from this community?",
          style: TextStyle(
            color: TColor.gray,
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Routemaster.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: TColor.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => removeMember(
              userId: userId,
              currentUserId: currentUserId,
            ),
            child: Text(
              "Remove",
              style: TextStyle(
                color: TColor.primaryColor1,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addModeratorDialog({
    required String userName,
    required String userId,
    required String currentUserId,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Add $userName as Moderator",
          style: TextStyle(
            color: TColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          "Are you sure you want to make $userName as the moderator of this community?",
          style: TextStyle(
            color: TColor.gray,
            fontSize: 12,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Routemaster.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: TColor.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => addModerator(
              userId: userId,
              currentUserId: currentUserId,
            ),
            child: Text(
              "Add",
              style: TextStyle(
                color: TColor.primaryColor1,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider)!;
    final isLoading = ref.watch(communityControllerProvider);
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: TColor.primaryColor1,
            ),
          )
        : ref.watch(getCommunityByIdProvider(widget.communityId)).when(
              data: (community) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: TColor.white,
                    centerTitle: true,
                    elevation: 0,
                    title: Text(
                      isEdit ? "Edit Members" : "Members",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    leading: InkWell(
                      onTap: () => Routemaster.of(context).pop(),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: TColor.lightGray,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "assets/img/back_btn.png",
                          width: 15,
                          height: 15,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    actions: [
                      community.admin == currentUser.uid ||
                              community.moderators.contains(currentUser.uid)
                          ? InkWell(
                              onTap: () {
                                _toggle();
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: TColor.lightGray,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  isEdit ? Icons.done_all : Icons.edit,
                                  color: TColor.black,
                                  size: 20,
                                ),
                              ),
                            )
                          : Container(),
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
                  body: ref
                      .watch(getCommunityMembersProvider(widget.communityId))
                      .when(
                        data: (members) {
                          return ListView.builder(
                            itemCount: members.length,
                            itemBuilder: (context, index) {
                              final isMemberAdmin =
                                  members[index].uid == community.admin;
                              final isMemberModerator = community.moderators
                                  .contains(members[index].uid);
                              final isAdmin =
                                  currentUser.uid == community.admin;
                              final isModerator = community.moderators
                                  .contains(currentUser.uid);
                              final isSameUser =
                                  currentUser.uid == members[index].uid;
                              return GestureDetector(
                                onLongPress: (isEdit &&
                                            !isSameUser &&
                                            (isAdmin && !isMemberAdmin) ||
                                        (isModerator && !isMemberModerator))
                                    ? () {
                                        _removeMemberDialog(
                                          userName: members[index].name!,
                                          userId: members[index].uid,
                                          currentUserId: currentUser.uid,
                                        );
                                      }
                                    : null,
                                onVerticalDragStart: (isEdit &&
                                        !(isMemberAdmin || isMemberModerator) &&
                                        (isAdmin || isModerator) &&
                                        !isSameUser)
                                    ? (details) {
                                        _addModeratorDialog(
                                          userName: members[index].name!,
                                          userId: members[index].uid,
                                          currentUserId: currentUser.uid,
                                        );
                                      }
                                    : null,
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage("assets/img/u1.png"),
                                  ),
                                  title: Text(members[index].name!),
                                  subtitle: Text(members[index].email),
                                ),
                              );
                            },
                          );
                        },
                        error: (error, stackTrace) => const Center(
                          child: Text('Error'),
                        ),
                        loading: () => Center(
                          child: CircularProgressIndicator(
                            color: TColor.primaryColor1,
                          ),
                        ),
                      ),
                );
              },
              error: (error, stackTrace) => const Center(
                child: Text('Error'),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: TColor.primaryColor1,
                ),
              ),
            );
  }
}
