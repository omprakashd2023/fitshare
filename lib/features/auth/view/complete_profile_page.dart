import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colours.dart';

import '../../../common/widgets/custom_date_picker.dart';
import '../../../common/widgets/round_button.dart';
import '../../../common/widgets/round_textfield.dart';

import '../controller/auth_controller.dart';

class CompleteProfilePage extends ConsumerStatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  final TextEditingController _dateController = TextEditingController(),
      _weightController = TextEditingController(),
      _heightController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String _genderField = "Choose Gender";

  void _selectDate(BuildContext context) {
    showDatePickerDialog(context, selectedDate, (date) {
      setState(() {
        selectedDate = date;
        _dateController.text = "${date.toLocal()}".split(' ')[0];
      });
    });
  }

  void completeProfile() {
    ref.read(authControllerProvider.notifier).completeProfile(
          context: context,
          gender: _genderField,
          dateOfBirth: _dateController.text,
          weight: _weightController.text,
          height: _heightController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final isLoading = ref.watch(authControllerProvider);
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/img/complete_profile.png",
                        width: media.width,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Text(
                        "Let's complete your profile",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "It will help us to know more about you!",
                        style: TextStyle(color: TColor.gray, fontSize: 12),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: TColor.lightGray,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                        "assets/img/gender.png",
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                        color: TColor.gray,
                                      )),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: TColor.lightGray,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          items: [
                                            "Male",
                                            "Female",
                                            "Choose Gender"
                                          ]
                                              .map((name) => DropdownMenuItem(
                                                    value: name,
                                                    child: Text(
                                                      name,
                                                      style: TextStyle(
                                                        color: TColor.gray,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _genderField = value!;
                                            });
                                          },
                                          isExpanded: true,
                                          hint: Text(
                                            _genderField,
                                            style: TextStyle(
                                              color: TColor.gray,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: AbsorbPointer(
                                child: RoundTextField(
                                  controller: _dateController,
                                  hintText: "Date of Birth",
                                  icon: "assets/img/date.png",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundTextField(
                                    controller: _weightController,
                                    hintText: "Your Weight",
                                    icon: "assets/img/weight.png",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: TColor.secondaryG,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "KG",
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundTextField(
                                    controller: _heightController,
                                    hintText: "Your Height",
                                    icon: "assets/img/hight.png",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: TColor.secondaryG,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "CM",
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.25,
                            ),
                            RoundButton(
                              title: "Submit",
                              onPressed: () => completeProfile(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
