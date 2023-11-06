import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Constants
import '../../../common/core/firebase_constants.dart';

//Firebase Provider
import '../../../common/providers/firebase_providers.dart';

//Typedefs
import '../../../common/typedef.dart';

//Failure Class
import '../../../common/failure.dart';

//Models
import '../../../models/workout_model.dart';

//Workout Provider
final workoutRepositoryProvider = Provider(
  (ref) => WorkoutRepository(
    firestore: ref.watch(firestoreProvider),
  ),
);

class WorkoutRepository {
  final FirebaseFirestore _firestore;

  WorkoutRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  //Workout Collection
  CollectionReference get _workouts =>
      _firestore.collection(FirebaseConstants.workoutsCollection);

  FutureEither<void> addWorkout(Workout workout) async {
    try {
      final userWorkouts = _workouts.doc(workout.userId).collection("workouts");
      await userWorkouts.add(workout.toMap());
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Workout>> fetchWorkouts(String userId) {
    final userWorkouts = _workouts.doc(userId).collection("workouts");
    return userWorkouts.snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return Workout.fromMap(doc.data());
          },
        ).toList();
      },
    );
  }
}
