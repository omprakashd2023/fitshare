import 'package:flutter/material.dart';

import '../colours.dart';

class IconTitleDropdownRow extends StatelessWidget {
  final String icon;
  final String title;
  final String selectedValue;
  final List<String> dropdownValues;
  final ValueChanged<String?> onChanged;

  const IconTitleDropdownRow({
    super.key,
    required this.icon,
    required this.title,
    required this.selectedValue,
    required this.dropdownValues,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.lightGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 30,
            alignment: Alignment.center,
            child: Image.asset(
              icon,
              width: 18,
              height: 18,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: TColor.gray,
                fontSize: 14,
              ),
            ),
          ),
          DropdownButton<String>(
            value: selectedValue,
            items: dropdownValues.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(color: TColor.gray, fontSize: 12),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            underline: const SizedBox(),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
