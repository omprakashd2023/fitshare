import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Constants
import '../../../common/core/firebase_constants.dart';

//Providers
import '../../../common/providers/firebase_providers.dart';

//Typedefs
import '../../../common/typedef.dart';

//Failure Class
import '../../../common/failure.dart';

//Community Model
import '../../../models/community_model.dart';
import '../../../models/user_model.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class CommunityRepository {
  final FirebaseFirestore _firestore;

  CommunityRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  //Community Collection
  CollectionReference get _community =>
      _firestore.collection(FirebaseConstants.communitiesCollection);

  //User Collection
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureEither<void> createCommunity({
    required Community community,
  }) async {
    try {
      var communityDoc = await _community.doc(community.name).get();
      if (communityDoc.exists) {
        return left(Failure("Community already exists"));
      }
      return right(
        _community.doc(community.name).set(
              community.toMap(),
            ),
      );
    } on FirebaseException catch (err) {
      throw err.message!;
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureVoid joinCommunity({
    required String communityId,
    required String userId,
  }) async {
    try {
      var communityDoc = await _community.doc(communityId).get();
      if (!communityDoc.exists) {
        return left(Failure("Community does not exist"));
      }
      return right(
        _community.doc(communityId).update(
          {
            "members": FieldValue.arrayUnion([userId]),
          },
        ),
      );
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureVoid leaveCommunity({
    required String communityId,
    required String userId,
  }) async {
    try {
      var communityDoc = await _community.doc(communityId).get();
      if (!communityDoc.exists) {
        return left(Failure("Community does not exist"));
      }
      final community = Community.fromMap(
        communityDoc.data() as Map<String, dynamic>,
      );
      if (community.admin == userId) {
        return left(Failure("You cannot leave the community as admin"));
      }
      return right(
        _community.doc(communityId).update(
          {
            "members": FieldValue.arrayRemove([userId]),
          },
        ),
      );
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  Stream<List<Community>> searchCommunities({required String query}) {
    final searchQuery = query.toLowerCase();
    return _community.snapshots().map(
      (snapshot) {
        List<Community> communities = [];
        for (var doc in snapshot.docs) {
          var communityData = doc.data() as Map<String, dynamic>;
          var community = Community.fromMap(communityData);
          if (community.name.toLowerCase().contains(searchQuery)) {
            communities.add(community);
          }
        }
        return communities;
      },
    );
  }

  Stream<List<UserModel>> getCommunityMembers({required String communityId}) {
    return _community.doc(communityId).snapshots().map((snapshot) {
      var communityData = snapshot.data() as Map<String, dynamic>;
      var community = Community.fromMap(communityData);
      List<UserModel> members = [];
      for (var member in community.members) {
        _users.doc(member).get().then(
              (userData) => members.add(
                UserModel.fromMap(userData.data() as Map<String, dynamic>),
              ),
            );
      }
      return members;
    });
  }

  Stream<List<Community>> getAllCommunities() {
    return _community.snapshots().map((snapshot) {
      List<Community> communities = [];
      for (var doc in snapshot.docs) {
        communities.add(
          Community.fromMap(doc.data() as Map<String, dynamic>),
        );
      }
      return communities;
    });
  }

  Stream<List<Community>> getUserCommunities({
    required String userId,
  }) {
    return _community
        .where('members', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      List<Community> communities = [];
      for (var doc in snapshot.docs) {
        communities.add(
          Community.fromMap(doc.data() as Map<String, dynamic>),
        );
      }
      return communities;
    });
  }

  Stream<Community> getCommunityById({
    required String communityId,
  }) {
    return _community.doc(communityId).snapshots().map((snapshot) {
      return Community.fromMap(snapshot.data() as Map<String, dynamic>);
    });
  }

  FutureVoid removeMember({
    required String communityId,
    required String userId,
    required String currentUserId,
  }) async {
    try {
      var communityDoc = await _community.doc(communityId).get();
      final community = Community.fromMap(
        communityDoc.data() as Map<String, dynamic>,
      );
      if (!(community.admin == currentUserId) ||
          !community.moderators.contains(currentUserId)) {
        return left(Failure("You cannot edit the community."));
      }
      return right(
        _community.doc(communityId).update(
          {
            "members": FieldValue.arrayRemove([userId]),
          },
        ),
      );
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }

  FutureVoid addModerator({
    required String communityId,
    required String userId,
    required String currentUserId,
  }) async {
    try {
      var communityDoc = await _community.doc(communityId).get();
      final community = Community.fromMap(
        communityDoc.data() as Map<String, dynamic>,
      );
      if (!(community.admin == currentUserId) ||
          !community.moderators.contains(currentUserId)) {
        return left(Failure("You cannot edit the community."));
      }
      return right(
        _community.doc(communityId).update(
          {
            "moderators": FieldValue.arrayUnion([userId]),
          },
        ),
      );
    } catch (err) {
      return left(Failure(err.toString()));
    }
  }
}
