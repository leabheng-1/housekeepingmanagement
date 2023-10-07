import 'package:flutter/material.dart';

class AddBookingSubBotton extends StatelessWidget {
  final String hintTitle;
  final String title;
  final TextEditingController controller;

  const AddBookingSubBotton({
    super.key,
    required this.hintTitle,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(
          width: 170,
          height: 35,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintTitle,
              hintStyle: const TextStyle(fontSize: 15),
              filled: true,
              fillColor: const Color.fromARGB(255, 232, 231, 231),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        )
      ],
    );
  }
}
