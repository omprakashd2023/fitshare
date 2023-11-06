import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

//Models
import '../../../models/workout_model.dart';

//Repository
import '../../auth/controller/auth_controller.dart';
import '../repository/workout_repository.dart';

//Utils
import '../../../common/utils.dart';

final workoutControllerProvider =
    StateNotifierProvider<WorkoutController, bool>(
  (ref) => WorkoutController(
    workoutRepository: ref.watch(workoutRepositoryProvider),
    ref: ref,
  ),
);

final getUserWorkoutProvider = StreamProvider(
  (ref) {
    final workoutController = ref.watch(workoutControllerProvider.notifier);
    return workoutController.fetchWorkouts();
  },
);

class WorkoutController extends StateNotifier<bool> {
  final WorkoutRepository _workoutRepository;
  final Ref _ref;
  WorkoutController({
    required WorkoutRepository workoutRepository,
    required Ref ref,
  })  : _workoutRepository = workoutRepository,
        _ref = ref,
        super(false); //Loading State

  //Add Workout
  void addWorkout(
    BuildContext context, {
    required String name,
    required String startTime,
    required String repetitions,
    required String difficulty,
  }) async {
    state = true;
    final workout = Workout(
      name: name,
      startTime: startTime,
      repetitions: repetitions,
      difficulty: difficulty,
      userId: _ref.read(userProvider)!.uid,
    );
    final res = await _workoutRepository.addWorkout(workout);
    state = false;
    res.fold((err) {
      showSnackBar(context, err.message);
    }, (res) {
      showSnackBar(context, "Workout Added Successfully");
      Routemaster.of(context).pop();
    });
  }

  //Fetch Workouts
  Stream<List<Workout>> fetchWorkouts() {
    return _workoutRepository.fetchWorkouts(_ref.read(userProvider)!.uid);
  }
}
