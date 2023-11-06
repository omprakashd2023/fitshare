import 'package:flutter/material.dart';

import '../colours.dart';

class DatePickerDialog extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerDialog({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<DatePickerDialog> {
  late DateTime _pickedDate;

  @override
  void initState() {
    super.initState();
    _pickedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Select a Date',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              CalendarDatePicker(
                initialDate: _pickedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
                onDateChanged: (date) {
                  setState(() {
                    _pickedDate = date;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        TColor.primaryColor1,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        TColor.primaryColor1,
                      ),
                    ),
                    onPressed: () {
                      widget.onDateSelected(_pickedDate);
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showDatePickerDialog(BuildContext context, DateTime selectedDate,
    Function(DateTime) onDateSelected) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: TColor.black.withOpacity(0.5),
    transitionDuration:
        const Duration(milliseconds: 400), // Adjust the duration
    pageBuilder: (context, animation1, animation2) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: animation1,
            curve: Curves.easeOut, // Adjust the curve for smoother animation
          ),
        ),
        child: DatePickerDialog(
          selectedDate: selectedDate,
          onDateSelected: onDateSelected,
        ),
      );
    },
  );
}
