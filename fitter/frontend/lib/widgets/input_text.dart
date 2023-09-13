import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  const InputText({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 3,
            ),
          ),
          labelText: hintText,
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromARGB(207, 74, 124, 174),
          )),
    );
  }
}
