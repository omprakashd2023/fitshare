import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../common/colours.dart';
import '../../../common/widgets/round_button.dart';
import '../../../common/widgets/round_textfield.dart';

// Controller
import '../controller/auth_controller.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool isCheck = false, isHidePassword = true, isHideConfirmPassword = true;
  final TextEditingController _firstNameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController();

  void signInWithGoogle() {
    ref
        .read(authControllerProvider.notifier)
        .signInWithGoogle(context: context);
  }

  void signUpWithEmail() {
    ref.read(authControllerProvider.notifier).signUpWithEmail(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Text(
                        "Hey there,",
                        style: TextStyle(color: TColor.gray, fontSize: 16),
                      ),
                      Text(
                        "Create an Account",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      RoundTextField(
                        hintText: "First Name",
                        icon: "assets/img/user_text.png",
                        controller: _firstNameController,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        hintText: "Last Name",
                        icon: "assets/img/user_text.png",
                        controller: _lastNameController,
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
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        hintText: "Confirm Password",
                        icon: "assets/img/lock.png",
                        obscureText: isHideConfirmPassword,
                        controller: _confirmPasswordController,
                        rigtIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              isHideConfirmPassword = !isHideConfirmPassword;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: Icon(
                              isHideConfirmPassword
                                  ? Icons.lock_open_outlined
                                  : Icons.lock_outline,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isCheck = !isCheck;
                              });
                            },
                            icon: Icon(
                              isCheck
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank_outlined,
                              color: TColor.gray,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "By continuing you accept our Privacy Policy and\nTerm of Use",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.15,
                      ),
                      RoundButton(
                        title: "Register",
                        onPressed: () => signUpWithEmail(),
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
                            onTap: () => signInWithGoogle(),
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
                          Routemaster.of(context).replace('/login');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
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
