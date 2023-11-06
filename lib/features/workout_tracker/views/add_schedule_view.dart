import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colours.dart';
import '../../../common/utils.dart';
import '../../../common/widgets/icon_title_drop_down.dart';
import '../../../common/widgets/round_button.dart';

//Controller
import '../controller/workout_controller.dart';

class AddScheduleView extends ConsumerStatefulWidget {
  final DateTime date;
  const AddScheduleView({super.key, required this.date});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddScheduleViewState();
}

class _AddScheduleViewState extends ConsumerState<AddScheduleView> {
  var selectedWorkout = "Upperbody";
  var selectedDifficulty = "Beginner";
  var selectedRepetitions = "10 Days";
  var selectedTime = DateTime.now();

  void addWorkoutSchedule() {
    DateTime date = DateTime.parse(widget.date.toString().split(" ")[0]);
    DateTime time = DateTime.parse("$selectedTime");
    DateTime workoutTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    ref.read(workoutControllerProvider.notifier).addWorkout(
          context,
          name: selectedWorkout,
          startTime: dateToString(workoutTime),
          repetitions: selectedRepetitions,
          difficulty: selectedDifficulty,
        );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var isLoading = ref.watch(workoutControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/closed_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Add Schedule",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
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
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: TColor.primaryColor1,
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/img/date.png",
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.date.toString().split(" ")[0],
                        style: TextStyle(color: TColor.gray, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: media.width * 0.35,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (newTime) {
                        setState(() {
                          selectedTime = newTime;
                        });
                      },
                      initialDateTime: DateTime.now(),
                      use24hFormat: false,
                      minuteInterval: 1,
                      mode: CupertinoDatePickerMode.time,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Details Workout",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  IconTitleDropdownRow(
                    icon: "assets/img/choose_workout.png",
                    title: "Choose Workout",
                    dropdownValues: const ["Upperbody", "Lowerbody", "Abs"],
                    selectedValue: selectedWorkout,
                    onChanged: (value) {
                      setState(() {
                        selectedWorkout = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconTitleDropdownRow(
                    icon: "assets/img/difficulity.png",
                    title: "Choose Difficulty",
                    dropdownValues: const ["Beginner", "Medium", "Advanced"],
                    selectedValue: selectedDifficulty,
                    onChanged: (value) {
                      setState(() {
                        selectedDifficulty = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconTitleDropdownRow(
                    icon: "assets/img/repetitions.png",
                    title: "Choose Repetitions",
                    dropdownValues: const ["10 Days", "20 Days", "30 Days"],
                    selectedValue: selectedRepetitions,
                    onChanged: (value) {
                      setState(() {
                        selectedRepetitions = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  RoundButton(
                    title: "Save",
                    onPressed: () => addWorkoutSchedule(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}
