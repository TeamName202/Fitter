import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> dropList;
  final String hintText;
  final double width;
  const Dropdown({
    super.key,
    required this.dropList,
    required this.hintText,
    required this.width,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      hintText: widget.hintText,
      width: widget.width,
      inputDecorationTheme: const InputDecorationTheme(),
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.dropList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
