import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

//Models
import '../../../models/community_model.dart';
import '../../../models/user_model.dart';

//Repository
import '../repository/community_repository.dart';

//Controllers
import '../../auth/controller/auth_controller.dart';

//Utils
import '../../../common/utils.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  return CommunityController(
    communityRepository: communityRepository,
    ref: ref,
  );
});

final searchCommunitiesProvider =
    StreamProvider.family<List<Community>, String>(
  (ref, String query) {
    final communityController = ref.watch(communityControllerProvider.notifier);
    return communityController.searchCommunities(query: query);
  },
);

final getCommunityMembersProvider =
    StreamProvider.family<List<UserModel>, String>((ref, String communityId) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getCommunityMembers(communityId: communityId);
});

final getAllCommunitiesProvider = StreamProvider<List<Community>>((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getAllCommunities();
});

final userCommunityProvider =
    StreamProvider.family<List<Community>, String>((ref, String userId) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities(userId: userId);
});

final getCommunityByIdProvider =
    StreamProvider.family<Community, String>((ref, String communityId) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getCommunityById(
    communityId: communityId,
  );
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        super(false);

  //Create Community
  void createCommunity({
    required String name,
    required String description,
    required String location,
    required BuildContext context,
  }) async {
    state = true;
    var user = _ref.read(userProvider)!.uid;
    var community = Community(
      id: name,
      name: name,
      description: description,
      location: location,
      members: [user],
      moderators: [user],
      admin: user,
    );
    var result = await _communityRepository.createCommunity(
      community: community,
    );
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      Routemaster.of(context).pop();
    });
  }

  //Join Community
  void joinCommunity({
    required String communityId,
    required BuildContext context,
  }) async {
    state = true;
    var user = _ref.read(userProvider)!.uid;
    var result = await _communityRepository.joinCommunity(
      communityId: communityId,
      userId: user,
    );
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, "Joined the Community");
    });
  }

  //Leave Community
  void leaveCommunity({
    required String communityId,
    required BuildContext context,
  }) async {
    state = true;
    var user = _ref.read(userProvider)!.uid;
    var result = await _communityRepository.leaveCommunity(
      communityId: communityId,
      userId: user,
    );
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, "You Left the Community");
      Routemaster.of(context).pop();
    });
  }

  //Search Communities
  Stream<List<Community>> searchCommunities({
    required String query,
  }) {
    return _communityRepository.searchCommunities(query: query);
  }

  //Get Community Members
  Stream<List<UserModel>> getCommunityMembers({
    required String communityId,
  }) {
    return _communityRepository.getCommunityMembers(communityId: communityId);
  }

  //Get All Communities
  Stream<List<Community>> getAllCommunities() {
    return _communityRepository.getAllCommunities();
  }

  //Get User Communities
  Stream<List<Community>> getUserCommunities({
    required String userId,
  }) {
    return _communityRepository.getUserCommunities(userId: userId);
  }

  //Get Community By Name
  Stream<Community> getCommunityById({
    required String communityId,
  }) {
    return _communityRepository.getCommunityById(
      communityId: communityId,
    );
  }

  //Remove Member
  void removeMember({
    required String communityId,
    required String userId,
    required String currentUserId,
    required BuildContext context,
  }) async {
    state = true;
    var result = await _communityRepository.removeMember(
      communityId: communityId,
      userId: userId,
      currentUserId: currentUserId,
    );
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, "Member Removed.");
    });
  }

  //Add Moderator
  void addModerator({
    required String communityId,
    required String userId,
    required String currentUserId,
    required BuildContext context,
  }) async {
    state = true;
    var result = await _communityRepository.addModerator(
      communityId: communityId,
      userId: userId,
      currentUserId: currentUserId,
    );
    state = false;
    result.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      showSnackBar(context, "Moderator Added.");
    });
  }
}
