import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

//Models
import '../../../models/user_model.dart';

//Repository
import '../repository/auth_repository.dart';

//Utils
import '../../../common/utils.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(authControllerProvider.notifier).authStateChanges,
);

final getUserDataProvider = StreamProvider.family(
  (ref, String uid) =>
      ref.watch(authControllerProvider.notifier).getUserData(uid),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false); //Loading State

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Stream<UserModel> getUserData(String uid) => _authRepository.getUserData(uid);

  //Sign Out
  void signOut({required BuildContext context}) async {
    _authRepository.signOut();
    Routemaster.of(context).pop();
  }

  //Google Sign In
  void signInWithGoogle({required BuildContext context}) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (err) {
        showSnackBar(context, err.message);
        Routemaster.of(context).pop();
      },
      (userModel) {
        _ref.read(userProvider.notifier).update(
              (state) => userModel,
            );
      },
    );
  }

  //Email Sign Up
  void signUpWithEmail({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = true;
    final user = await _authRepository.signUpWithEmail(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    state = false;
    user.fold(
      (err) {
        showSnackBar(context, err.message);
      },
      (userModel) {
        _ref.read(userProvider.notifier).update(
              (state) => userModel,
            );
      },
    );
  }

  //Email Sign In
  void signInWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final user = await _authRepository.signInWithEmail(
      email: email,
      password: password,
    );
    state = false;
    user.fold(
      (err) {
        showSnackBar(context, err.message);
      },
      (userModel) {
        _ref.read(userProvider.notifier).update(
              (state) => userModel,
            );
        Routemaster.of(context).replace('/');
      },
    );
  }

  //Complete Profile
  void completeProfile({
    required BuildContext context,
    required String gender,
    required String dateOfBirth,
    required String weight,
    required String height,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;
    if (user.goalIndex != null) {
      user = user.copyWith(
        isCompletedProfile: true,
        dateOfBirth: dateOfBirth,
        weight: weight,
        height: height,
        gender: gender,
      );
    } else {
      user = user.copyWith(
        dateOfBirth: dateOfBirth,
        weight: weight,
        height: height,
        gender: gender,
      );
    }
    final res = await _authRepository.updateProfile(user: user);
    state = false;
    res.fold((err) {
      showSnackBar(context, err.message);
    }, (res) {
      _ref.read(userProvider.notifier).update((state) => user);
      Routemaster.of(context).replace('/main-tab');
    });
  }

  //Set Your Goal
  void setGoals({
    required BuildContext context,
    required int goalIndex,
  }) async {
    state = true;
    UserModel user = _ref.read(userProvider)!;
    if (user.weight != null) {
      user = user.copyWith(
        isCompletedProfile: true,
        goalIndex: goalIndex,
      );
    } else {
      user = user.copyWith(
        goalIndex: goalIndex,
      );
    }
    final res = await _authRepository.updateProfile(user: user);
    state = false;
    res.fold((err) {
      showSnackBar(context, err.message);
    }, (res) {
      _ref.read(userProvider.notifier).update((state) => user);
      Routemaster.of(context).replace('/main-tab');
    });
  }
}
