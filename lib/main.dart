import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import './router.dart';

import './firebase_options.dart';

import './models/user_model.dart';

import './features/auth/controller/auth_controller.dart';

import './common/colours.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: FitShare(),
    ),
  );
}

class FitShare extends ConsumerStatefulWidget {
  const FitShare({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FitShareState();
}

class _FitShareState extends ConsumerState<FitShare> {
  UserModel? userModel;

  void getUserData(User user) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(user.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(
          data: (userData) => MaterialApp.router(
            title: 'FitShare',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: TColor.primaryColor1,
              fontFamily: "Poppins",
            ),
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (userData != null) {
                getUserData(userData);
                if (userModel != null) {
                  return loggedInRoutes;
                }
              }
              return loggedOutRoutes;
            }),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => const Center(
            child: Text("Error"),
          ),
          loading: () => const CircularProgressIndicator(),
        );
  }
}