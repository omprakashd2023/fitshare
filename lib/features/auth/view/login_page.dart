import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../common/colours.dart';
import '../../../common/widgets/round_button.dart';
import '../../../common/widgets/round_textfield.dart';

// Controller
import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isCheck = false, isHidePassword = true;
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  void signInWithEmail() {
    ref.read(authControllerProvider.notifier).signInWithEmail(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: TColor.primaryColor1,
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: media.height * 0.9,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: media.width * 0.2,
                      ),
                      Text(
                        "Hey there,",
                        style: TextStyle(color: TColor.gray, fontSize: 16),
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        hintText: "Email",
                        icon: "assets/img/email.png",
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        hintText: "Password",
                        icon: "assets/img/lock.png",
                        obscureText: isHidePassword,
                        controller: _passwordController,
                        rigtIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              isHidePassword = !isHidePassword;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: Icon(
                              isHidePassword
                                  ? Icons.lock_open_outlined
                                  : Icons.lock_outline,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot your password?",
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 10,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      const Spacer(),
                      RoundButton(
                        title: "Login",
                        onPressed: () => signInWithEmail(),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: TColor.gray.withOpacity(0.5),
                          )),
                          Text(
                            "  Or  ",
                            style: TextStyle(color: TColor.black, fontSize: 12),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: TColor.gray.withOpacity(0.5),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: TColor.white,
                                border: Border.all(
                                  width: 1,
                                  color: TColor.gray.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                "assets/img/google.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: media.width * 0.04,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: TColor.white,
                                border: Border.all(
                                  width: 1,
                                  color: TColor.gray.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                "assets/img/facebook.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      TextButton(
                        onPressed: () {
                          Routemaster.of(context).pop();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Don't have an account yet? ",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Register",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
