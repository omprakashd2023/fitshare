import 'package:flutter/material.dart';
import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colours.dart';
import '../../../common/utils.dart';
import '../../../common/widgets/round_button.dart';

import './add_schedule_view.dart';

//Controller
import '../controller/workout_controller.dart';

class WorkoutScheduleView extends ConsumerStatefulWidget {
  const WorkoutScheduleView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutScheduleViewState();
}

class _WorkoutScheduleViewState extends ConsumerState<WorkoutScheduleView> {
  final CalendarAgendaController _calendarAgendaControllerAppBar =
      CalendarAgendaController();
  late DateTime _selectedDateAppBBar;

  List eventArr = [];

  List selectDayEventArr = [];

  @override
  void initState() {
    super.initState();
    _selectedDateAppBBar = DateTime.now();
  }

  void setDayEventWorkoutList() {
    var date = dateToStartDate(_selectedDateAppBBar);
    selectDayEventArr = eventArr
        .map((wObj) {
          int repetitions =
              int.parse(wObj["repetitions"].toString().split(" ")[0]);
          DateTime startTime = DateTime.parse(
            getStringDateToOtherFormate(
              wObj["startTime"].toString(),
              outFormatStr: "yyyy-MM-dd hh:mm:ss.sss",
            ),
          );
          DateTime endTime = startTime.add(Duration(days: repetitions - 1));
          if (startTime.isBefore(date.add(const Duration(days: 1))) &&
              endTime.isAfter(date)) {
            return {
              "name": wObj["name"],
              "startTime": wObj["startTime"],
              "date": stringToDate(wObj["startTime"].toString(),
                  formatStr: "dd/MM/yyyy hh:mm aa")
            };
          }
          return null;
        })
        .where((wObj) => wObj != null)
        .toList();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
              "assets/img/back_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Workout Schedule",
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
      body: ref.watch(getUserWorkoutProvider).when(
            data: (workOutData) {
              setState(() {
                eventArr =
                    workOutData.map((workout) => workout.toMap()).toList();
              });
              setDayEventWorkoutList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarAgenda(
                    controller: _calendarAgendaControllerAppBar,
                    appbar: false,
                    selectedDayPosition: SelectedDayPosition.center,
                    leading: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/ArrowLeft.png",
                          width: 15,
                          height: 15,
                        )),
                    training: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          "assets/img/ArrowRight.png",
                          width: 15,
                          height: 15,
                        )),
                    weekDay: WeekDay.short,
                    dayNameFontSize: 12,
                    dayNumberFontSize: 16,
                    dayBGColor: Colors.grey.withOpacity(0.15),
                    titleSpaceBetween: 15,
                    backgroundColor: Colors.transparent,
                    // fullCalendar: false,
                    fullCalendarScroll: FullCalendarScroll.horizontal,
                    fullCalendarDay: WeekDay.short,
                    selectedDateColor: Colors.white,
                    dateColor: Colors.black,
                    locale: 'en',

                    initialDate: DateTime.now(),
                    calendarEventColor: TColor.primaryColor2,
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime.now().add(const Duration(days: 30)),

                    onDateSelected: (date) {
                      _selectedDateAppBBar = date;
                      setDayEventWorkoutList();
                    },
                    selectedDayLogo: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: TColor.primaryG,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: media.width * 1.5,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // var availWidth = (media.width * 1.2) - (80 + 40);
                            var slotArr = selectDayEventArr.where((wObj) {
                              return (wObj["date"] as DateTime).hour == index;
                            }).toList();

                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      getTime(index * 60),
                                      style: TextStyle(
                                        color: TColor.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  if (slotArr.isNotEmpty)
                                    Expanded(
                                        child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: slotArr.map((sObj) {
                                        var min =
                                            (sObj["date"] as DateTime).minute;
                                        //(0 to 2)
                                        var pos = (min / 60) * 2 - 1;

                                        return Align(
                                          alignment: Alignment(pos, 0),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 15,
                                                          horizontal: 20),
                                                      decoration: BoxDecoration(
                                                        color: TColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8),
                                                                  height: 40,
                                                                  width: 40,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: TColor
                                                                        .lightGray,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/img/closed_btn.png",
                                                                    width: 15,
                                                                    height: 15,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "Workout Schedule",
                                                                style: TextStyle(
                                                                    color: TColor
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              InkWell(
                                                                onTap: () {},
                                                                child:
                                                                    Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8),
                                                                  height: 40,
                                                                  width: 40,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: TColor
                                                                          .lightGray,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/img/more_btn.png",
                                                                    width: 15,
                                                                    height: 15,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            sObj["name"]
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  TColor.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                "assets/img/time_workout.png",
                                                                height: 20,
                                                                width: 20,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                "${getDayTitle(sObj["startTime"].toString())}|${getStringDateToOtherFormate(sObj["startTime"].toString(), outFormatStr: "h:mm aa")}",
                                                                style: TextStyle(
                                                                    color: TColor
                                                                        .gray,
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          RoundButton(
                                                            title: "Mark Done",
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 35,
                                              // width: availWidth * 0.5,
                                              width:
                                                  calculateContainerWidth(sObj),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: TColor.secondaryG),
                                                borderRadius:
                                                    BorderRadius.circular(17.5),
                                              ),
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  "${sObj["name"].toString()}, ${getStringDateToOtherFormate(sObj["startTime"].toString(), outFormatStr: "h:mm aa")}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: TColor.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ))
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: TColor.gray.withOpacity(0.2),
                              height: 1,
                            );
                          },
                          itemCount: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) {
              return const Center(
                child: Text("Error"),
              );
            },
            loading: () => Center(
              child: CircularProgressIndicator(
                color: TColor.primaryColor1,
              ),
            ),
          ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScheduleView(
                date: _selectedDateAppBBar,
              ),
            ),
          );
        },
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.secondaryG),
              borderRadius: BorderRadius.circular(27.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ]),
          alignment: Alignment.center,
          child: Icon(
            Icons.add,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),
    );
  }

  double calculateContainerWidth(Map<String, dynamic> sObj) {
    final text =
        "${sObj["name"].toString()}, ${getStringDateToOtherFormate(sObj["startTime"].toString(), outFormatStr: "h:mm aa")}";
    const textStyle = TextStyle(fontSize: 12);

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    const extraPadding = 16.0;

    return textPainter.width + extraPadding;
  }
}
